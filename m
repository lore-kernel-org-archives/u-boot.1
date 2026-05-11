Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CFBCD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73AE83C2B;
	Mon, 11 May 2026 22:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GXnfbh0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED888460E; Mon, 11 May 2026 22:43:42 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EAFA8394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-479e4835e26so2807255b6e.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778532219; x=1779137019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drzz3D3mMFliFediqQzFfSrBHShrHcKAXAtNzBz8bMo=;
 b=GXnfbh0q/8KPVH089aeLQ0/i8AayCqntvEBZQZMyujbvrbGTtNPHMSWptJKRCsVoJg
 ApbJnpfHx89/Zei1OwZgazvS+5NfWagpWscO/pF2j1HsiRnkXlTi6DFmdJ6ipn78uSiD
 WtKYjtT84QbawYLrLvwhafgOOZ44PAZZt/x6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778532219; x=1779137019;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=drzz3D3mMFliFediqQzFfSrBHShrHcKAXAtNzBz8bMo=;
 b=adUAciMzL58OLk3B5yFNTCttiIqdXx5xOSuOXdxM4yLkcNHUGtN4c5J8RLvb8Ey7/J
 ydj7SRk3W7jxn+pxAS3SxofvtPgM2AGHTpGREFc5cqrcV3PssUCGSzJ7wDn/MXtwHhos
 XptlWFLDop5xMJxB+fdjwCeHO6FmJFYhV78rljL3cJMHOQspzH4E+5epDz+HpSS8qSPO
 QFWuxJtPrKykecoPzQk6fbrbJIjRN+wni27Bbe84sBoMZ+RXWYxNf2S6pvRosV2r0NO8
 TuBa/qM5uD0hFpyneDBwzdy/vo+QI0sd2qvIe9HaPT12KlI3GQAX/bWTT1PYGvMsTnFU
 Nclg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UGwnjkXBUSQcSlnKbGe+6I7qLlV0UmvbpZZMpsdYq2VE5q1BZ8tVwYjUg3EDTTAhTAwLy1ak=@lists.denx.de
X-Gm-Message-State: AOJu0YwnYoezjjIukQWCTTzsbYfyHY7K/hi5pEkzDNauNRXGoF/JdsZi
 vBfsz6hNnZ+/L0AjWsBOhQXMknkrWO0Y+OEC6VpkrdwcReUEae39qhQeebMvjYisTDte37Wygkh
 um/y3RjvzNtu8
X-Gm-Gg: Acq92OFzD85CVmhr9NPR7sNGNenZhG6BeKtwrG2zNc0kLSuR9NnOnaK0Ic7QNs8x2dw
 07rnxvpFHBIqhESNRYAbBZeyCuhqFPGCd+iA/VM3vYmQGUhByNhKu0+RFMnajmb1zTKIu8z2l4Y
 3JyyXd2s5kGk8yx9Opxx7TEUJGyCEOIcRdlOQlndAlTNsOccAPQ+pmZUDOnuppPiJbHmU8Tf7v/
 ix+cFNxuPWmCBRzkon59wfsO3P7hD+0cDZi+hLeiUzLz0n8piDy2yn44uGyvLeFoI9I7EpKvRou
 eCCJ4SlunyIZ/osmV4qD/xAWlPDo65z1fftXejqr2SS/V1MBV25BWMsfslUcaPpJTD5eslIC8N5
 t7a51sBsM23Kz5x2ujpyD9KAk4YkbUlGjvl25gqmO4n3Qu2Rfdwv0kXdEshMYQAJe7AXzMrw5A7
 Fb2KYrROKnha838E3ayfxnPsrpbe3uN2jpR+VnDDc8388VsQ1isu/ko0cYFeQf6gWwp+Ey3Bax5
 Cb5+qwZw6lyrp5pGYIGa6C08EYyNbCKqDQ8XTxw5W3NAfrnZw==
X-Received: by 2002:a05:6808:e3c5:b0:45e:f443:dc3d with SMTP id
 5614622812f47-48297137030mr123255b6e.13.1778532219065; 
 Mon, 11 May 2026 13:43:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e00sm7505796a34.7.2026.05.11.13.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:43:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Peng Fan <peng.fan@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Simon Kagstrom <simon.kagstrom@netinsight.net>, Stefan Roese <sr@denx.de>, 
 u-boot@lists.denx.de, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260505103816.202758-1-peter@pcc.me.uk>
References: <20260505103816.202758-1-peter@pcc.me.uk>
Subject: Re: [PATCH] fs: ubifs: fix bugs involving symlinks in ubifs_findfile
Message-Id: <177853221798.1608836.6191893582727653736.b4-ty@konsulko.com>
Date: Mon, 11 May 2026 14:43:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 05 May 2026 03:38:16 -0700, Peter Collingbourne wrote:

> When encountering a symlink pointing to an absolute path, ubifs_findfile
> would return the target of the symlink as the result instead of resolving
> any following components in the original path. Fix it by following the
> same code path that is used for relative paths except that we set the
> next inode to the root if we see a leading slash.
> 
> The existing code used memcpy and sprintf to copy the symlink target
> into a fixed size stack buffer and was therefore vulnerable to buffer
> overflows with a sufficiently long symlink target. Fix it by using a
> heap buffer for the temporary path during path resolution.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs: ubifs: fix bugs involving symlinks in ubifs_findfile
      commit: d5888d509cc43942ec98d993f2d129f5c8ddc432
-- 
Tom


