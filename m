Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89404C44515
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 15:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6E284E46;
	Fri, 17 Jul 2026 17:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DjT78fmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C7E84E4E; Fri, 17 Jul 2026 17:35:47 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70EAA84E36
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69e5f8a193bso1561686a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 08:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784302545; cv=none;
 d=google.com; s=arc-20260327;
 b=CJGtLb3lpNe/eFM67zq3Zd4LDdDBsOiRDAVildKD/jz6OEi6Aw5wyciztIrsIPuH07
 fgObLhRw0ADH1MwE17xHfkEOW3ld5e3dCC66BO5WN1GlR8qbBPAZfseyJV8/GwYCj8nf
 MMyzqG6i2aAVTlDnMe8hB6M3oQFTFhlqZ8i0qmcvGIShBcYY+NNBMAINNXIASTA+RZaG
 tRg8gf43FMhXY8TkyE/QqaQASN4V4ibH4D5FEb9tevRYxy3jj0IuDgz6Cbt8XjZQ7xxI
 ncOPvIb0GEL1BhqgJKLBQcFpRpGN6M9ZczPmKk/67947hfB8bPl7cK9kINh6xsRPj4JX
 bDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rhJqE3H1sPkKnbdRFmGbhiUaXiN0bYx/yGKQgb9n0mY=;
 fh=G1AkDUbmzhhIthXr2yLL4ZkDPWZxanPtGn0i8kjqkCY=;
 b=r9VdBArP/nbOR6Imj7bHCsGDb0LF2Mtwbr7RkhLTgSn4/DZ/JNNJndd1mDk9ddoNIW
 frntbm1O/0EMfzcP19uRNqUzx2bG5d0HTMzRsv5SGV9lld/7/+s38r5b2vz7hRjtUNHX
 oXXabX7q3JWVxjNGT+urXe+Falfucc9BDyv1+pKVxX1qdXXwnZ3tIjCPGr+wZg4/SZn2
 CUOtsci1gts5FqRyvFUTD1vnsp1afgaoDLft5di8qAk/I2naWSjqmdJ/juSZ7En0lrnk
 mh6OBgjEIxnp64jcTxlSEEaRxpnfvDNxegSUJvZBjGnAS9Wh6OhsxvkrXc6sl2k9ESgA
 DRTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784302545; x=1784907345; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rhJqE3H1sPkKnbdRFmGbhiUaXiN0bYx/yGKQgb9n0mY=;
 b=DjT78fmKhUND3aMGBJuevtD72Wkb4QHp6nJvTu3rPrUPl3nBNRAYi4vkCV0Sl/RYQT
 1sI5+RIcdMzAEMNNhxpdvBhfrFpakdngsPsl9GjxVeRpT1JmxJMqWOfFywFBGtbPvKzn
 lLCI8mvBm6pO7JFz4A02TVQTK6e0YhVr9fuHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784302545; x=1784907345;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rhJqE3H1sPkKnbdRFmGbhiUaXiN0bYx/yGKQgb9n0mY=;
 b=cGkQLayE5HOb32upsKBwtjqodXZO5qOL/jG1y18xjgjNA8CmfwED1a1y1dxyhojbOO
 qNFLWKbAOZxyiRWfqrIWJpt5/FD0zX5nvFcoVjMr++kaDRd5XVHd34T496Poa/KZxVAp
 qSaeGrPlBP4kL90C6qwp8mIKnsDL/CMVcZte9lshcdZeE9IjNV7AHvr7xzOZQcGi1rul
 Ld9kdDCwwxBB6XsD21oEQ3LSs64r526NfG2IW52W6CsiOa3x3MEs45UR+LwBDlP2zC7F
 rObrxyeeofhdUFzZI7Gw03wTKfnm5m5969/oV4Vg3RuigKJY+Sxra+ecfNW8Qdd3GE7I
 P0zw==
X-Gm-Message-State: AOJu0YyA/kkz0c2M5QC/W7OPJAawHr7TZA9zH7lKUQo4n9o2ptFa3DSc
 N+DIMAiqW2xTyLxCU51VX5FZk2rcX1aYYVg4LBDB9asSuVB30+t0GreYHhJCqVt5ATPY1thnvpa
 d+BbvOIqi2a2YMk2DP2fJl2hjYvwJb5PcMOTCi/NPQy6Zna+FSBc=
X-Gm-Gg: AfdE7clIEBSRyIEj1rTH5CeaGh6PkwEuQWwKb4ZDOiG2FbUSZehBixduGRdfGfbcTlf
 w3ZOvnRDDur6PQCLH9n+bh9zQGnIzykBXRi5EHKTPTHReF44WJN8xNKdqiyqVVnrXe7AkGheEgH
 n0C2y/Vgmkgf+ke0nX7rQ8nC2Ym0PPj7b0FyYrAP1/w9PWC2pfzDEuZ04TakTdF4lQxusrhm1uP
 50b3dwFPYxlxYxTEBkeA6ZDAJvcBLptSMKjA0YtIlqSrViPyeNxZvQPsyW+
X-Received: by 2002:a05:6402:11c8:b0:698:3b7c:be65 with SMTP id
 4fb4d7f45d1cf-69e652c5662mr1297202a12.33.1784302544890; Fri, 17 Jul 2026
 08:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260710153343.1839357-1-aristo.chen@canonical.com>
 <20260710153343.1839357-2-aristo.chen@canonical.com>
In-Reply-To: <20260710153343.1839357-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 09:35:27 -0600
X-Gm-Features: AUfX_mwFr7DP_QgVdpruhMFvlCv20UAwTEb3oJmgMm421jX39fCuUWE3bfsU1eM
Message-ID: <CAFLszTiWQ0DndXy12kttydEXwKH87GETLOq_1n25ehZbWhniaA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools: mkimage: fix stale data pointer in
 fit_import_data()
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-07-10T15:33:38, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: fix stale data pointer in fit_import_data()
>
> The data pointer and the name of the external data property are
> declared outside the loop over the image nodes, so their values leak
> from one image into the next. An image node that carries data-size but
> neither data-offset nor data-position then reuses the pointer of the
> previously imported image: the previous image's data is written into
> the node before the import aborts when it tries to delete an external
> data property the node does not have. Since that abort path only prints
> a debug message, mkimage fails without any indication of what is wrong.
> The failure mode also depends on the order of the image nodes: when no
> externally stored image precedes the malformed node, the stale pointer
> is still NULL, so the import skips the node and the hashing stage
> reports a proper error instead.
>
> Move the declarations into the loop so that each image starts from a
> clean state. A node without an external data reference is now skipped
> consistently regardless of node order, and a malformed node is always
> reported by the later processing stages with a proper error message.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/fit_image.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
