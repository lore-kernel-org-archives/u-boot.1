Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HsI11hKh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BcgX/rOi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A993406F1;
	Sat, 24 Oct 2026 22:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jgMYLBlG8gt; Sat, 24 Oct 2026 22:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35240406EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881361;
	b=AWOJ9abd3z+VJcduc9b/k+1/1pKoliBUWzqCiFpvZTCPdYy6Sp1WQ/d/DFOCyyNb4eth
	 2wVM4aO/p7fvtC/E7Jerj0CvS8Wck5tnw0qhQW/Kk0bYz6+lRJKIj8pMiDgQhm+awVpCv
	 wF29GCQwv5Acp9F93ORwegL7YG9qKPXIe/7G0gX0TfE8p50rAmd0s9Qtf5nNiyYrMrL4t
	 OC0F8DnYYWJlPSBcXg/njVrf/U9WCI7gCmUNhi9KO9LdMeX31x4yaWTH3J9AMxLHLXzQz
	 HoU6qNVI2KnmdWQhQIXTGkR1dbNosj5ptMv5JDP6rrPHMHALE/AjOn1uYmasiJXcZ8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RA1J+VrRFjSkAPoDNpOTbbVltcMJijOJ9bSzFYf68ow=;
	b=kpZT39chgopkK2iVr0hbM3MFVaQ6+CaVa9LdVZe7xsKq89Yx2V3Bmbl5a2OPT8dAcZtx
	 1+MxgmsHoTU4pqKcNCRmW1xnSWfn5OjB27HZOyYVztTeKBXwjfoEMMYIfHT37fTbJRZms
	 v7gpNXpvrI2HtbkNEdPexR/lQyjt/3AEbRoe+mfV2Ys8oXSvzQU9DSta+sous8Zxbwigc
	 FCVfClKUAbqJTiK0Ttsmuml8oNfRZY6iX3KEKh0RfbDutu7hdo3avSS67D7hFZh/OVfxZ
	 YJmzHX9Bfww4By/lOX5IupHmXTKlqBGRnphM6+MFufKGgUrbSPGDEiQ/aKAsCJFihBA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881361;
	bh=RA1J+VrRFjSkAPoDNpOTbbVltcMJijOJ9bSzFYf68ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HsI11hKhVgzcV172LbbaDKEEFi3eOmr/j7rk8aVqRk9bOyjg5t7MwcpDQ/YgLKkXK
	 CSQSaP6olRazZKCSQtNV+YnfKWU7/2z4kSh12Nf16OrS4T/h3+zlVEKI+/BRGMhTSz
	 GwC3zEbULZGshUEL0udYY3CMYGzL+FULAE4oTnbZCgqZqmMdgMOcmpplTVpzA1w37m
	 nkPIL5uCJCdtC+q34SKxazIQceDP8vgBq0Gfcke5INuscikRFcQdgdgg1dMR/4wXp2
	 zfVKwBpjt14nO28/uiKqd+ixev7tCllVV1INF43avZib2eLs4nwXBqiko7Fzae2OBg
	 c6s8d8NZtZGPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35240406EE;
	Sat, 24 Oct 2026 22:36:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B105D3C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 965006073C
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OsQkOldSgvWK for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B97F6069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881340;
 b=AhGSg0irQ+DOqlAlnL/UqEmy9f52iB7A61XwfOAklRYeGVCKAz+HSRDGIRmbf7d5YmuV
 JW9e/UbJacuR4gfchXP2NnBSB710TAA4gA0fibq4Lfu3fF6J7YYbJtxPM9jB5ypPCbJNU
 uK/IJZ4FtaMh5jUZ7WVIlA8fuykGXAUmijKuJxbmjS4GxKwLOX5Rni30hLSm2vm5VCfS8
 tvtzGQVQ4BBbGflH5yB6QDKxDcH4KwQ2XV34e7r/NnnKdmShvX4iThxOPqZ45zE9w2cJl
 jQH8Wnbe/mhUoPuGK+iKc97wRm4CdaCtcaKVR7TbJEHpnOFAGD1rzQ7ovWB/89w3jxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881340;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=RA1J+VrRFjSkAPoDNpOTbbVltcMJijOJ9bSzFYf68ow=;
 b=BRQr46N6WP6/ToCO4rH5u1iZ38OhCgjsVKdRumF1qfbPvpKUcwlnfw2B+7wJW478k5hK
 9pabal17hSArDgo4cjIvlx8r9fkLAEjW234pgTQYKp78w9FeB0nK7oZw7OjQJkxL+cBLQ
 RFPb/w419F615Cudwt518M3hIowwAZdfoUWVksWR5+pcNYemff0HYAUP0eDupFU7T1H3i
 zi9WP17k3CeZuUzMKdjVTilR4pNwCvKRBRcJp73WVEMy4Qho658qRHfjJspqeBKiQLeYW
 nkz/A4RBVt3tLQ84M62d7pgIhCp3DN1AFuX21xaqLbj04b7meHYdL0Nj9KJ4Gs1W9pg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="BcgX/rOi"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BcgX/rOi
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B97F6069B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:40 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-70094949641so1777324eaf.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881339; x=1793486139;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RA1J+VrRFjSkAPoDNpOTbbVltcMJijOJ9bSzFYf68ow=;
 b=BcgX/rOicLwjdEN6BRgb23lBQm9yKTiyOSA1E7oh08IAHGEVLknIEye920lCfokapT
 IAzUoBy4lht6u80bM2D1e7Huc5hzYytLsl4aUHG8c9dXSWZp8yOSiJT7X7FnEHpNAs47
 xMN4qiiNgrX91Lh6IW4CTstP3Q2KKs3uz4CBSjpGbcw/+ZtZfAoo/rB4pr5oapJEbIJv
 iAcFLyVrW+tnemqyQB0WeJHqfOTKiEn2+5gX0PFw/WgQAJMthHy5gTqwXomsM9J1oztF
 gbEZGVzQTEoYe5VL+/ZGIay+9KQ+mlV0dSS+IIswzzeDZq7Lucapc1EE3fZeBj37C9Em
 2tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881339; x=1793486139;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RA1J+VrRFjSkAPoDNpOTbbVltcMJijOJ9bSzFYf68ow=;
 b=JW0MS/EW3IBgcLfzkCJzgHo/bEtGR7dNm0IzqYR8Lci9ypeEGl/ZdvQ+9GBM1ddF8C
 9CQmECat6pJRRazo226s6U9zFHjtmMy8QasmbmuHdC2gUsPzBbClr6P1fPE4sy/4bl8s
 /Huy6rsY7mPpH9QKVj2RMUV8BdV4IzRIpc8yCT5Hyy65qUtGAQThsAUgBLb5MDm5j0ca
 sk88ZA34jE2lDdcLgv5xbPbeJ4Oo/3jNLEl9sITRqZCbTX3kvFa6+J4A/5AzedmdwuQr
 vw09YgfQtfXwOefI89D49XkpdUEQTX4wlOSp6uhDNBhGcFLKjsWWGwvfzCWP+UsNJHPF
 n+xw==
X-Gm-Message-State: AFq9FYImI3laQIv5wcw49YtGYkXPlDl7MOYxlPGt6+tFdc9bu1kilKl+
 N1d6Ub3CnS8VspiJ+Rt8ya4FMVnN5dTq9qt3mE2SlYaZLQpykNzz3L6H
X-Gm-Gg: AYBFou2+XZGr2mpyty+I6kfZVweZFNIklqTdUg58eJp4nVqSiQ82aBIqABumFck9XTL
 WPJliaDybwO45vGOxIWGgF801eLofSfEfg6lHsSMF0L3+DerBa/S5oajOu5Sj/KGbCJfwTxY+fz
 V8DVnRU/rtZ07wJTojII/IQ3bTsrU3ZKN2UjhGUACJK/bhONopuC3yaOnY24823+5m2O+ET6Daz
 UV2gKTenQfWx9U2tBN94alwFvNkbyaECb3Q8K+FTnHGPKk6dRJBthMr72BHXzk8M5yb14FSllwf
 NFp93J6U4lYGEEwbBuogTHsJBH352+ftp/xk2WyTHu+pTj5CYQfe8BF+NfFMLeMAYLhTLTFTfy4
 8Y4f0Lsa9+eLLegdVLo7tR/w1/IanlKl88WFmSPCn+ONqyjnPrSWA6YGFPjR8cz00pzWXs6bZtc
 hXj7wKw0Fz17pRocDMiIwxUu0h/gX0txPnlLdL3UISQj6VCUtXPDcGAxUpkgtvinbXmzuE5w4gf
 VHn8F5H+47RDSyOY2cX7dKWZsrllSh4mGI/A4+OUa5YPtQZpMMBmvfPduyeXAp7P/WeYAobcFmr
 5Y09vhgevfxgubgVBGeywHdRM5gUoh1bn41dD5e34V8FcnePLCyE9sbXhpKuUkjY1Gb1gKIyJHM
 STLHtmSnrMu7fWaI4rKA5SaDx1j7O02/r0ttWzxSx0JQCk+2OZK6xpGw9HnIhaG4qM1BfrVzJ28
 QkJ6SGxBOCd1LUMNI9aUlNsFTE
X-Received: by 2002:a05:6820:810c:b0:6f6:baee:3ccb with SMTP id
 006d021491bc7-70ba0b60b1dmr1241971eaf.9.1792881338897; 
 Sat, 24 Oct 2026 15:35:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:35:01 -0600
Subject: [PATCH v2 14/16] net: lwip: retry TFTP transfers using the network
 failure policy
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-14-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apply netretry and interface rotation after TFTP exhausts its packet
retries. Like the legacy stack, also restart after a peer error other
than file-not-found or access-denied. Distinguish peer errors from local
option and memory-write failures so invalid input is not retried.

Retire the failed transfer before restarting the shared runtime.
Rebuild each attempt from the original address and size, recalculate
automatic filenames for a replacement interface, and leave another
client's runtime intact if exclusive restart is refused. Keep Ctrl-C,
initialization and metadata publication failures terminal.

Retry initial route and device-send failures with the request timer.
Invalid requests and setup allocation failures remain terminal.

Apply the same policy to receive-server listening and transfer
timeouts, retaining its compiled timeout and retry defaults. A partial
upload must not advance the next attempt's cursor or byte count.

Cover bounded retry policies, peer errors, packet retries, partial
transfers, interface rotation and shared-runtime refusal in sandbox.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 doc/usage/cmd/tftpsrv.rst                         |   4 +-
 lib/lwip/lwip/src/apps/tftp/tftp.c                |  21 +-
 lib/lwip/lwip/src/include/lwip/apps/tftp_common.h |  16 +-
 net/lwip/tftp.c                                   |  75 ++--
 test/dm/lwip_tftp.c                               |  73 +++-
 test/dm/tftp.c                                    | 403 ++++++++++++++++++++--
 6 files changed, 517 insertions(+), 75 deletions(-)

diff --git a/doc/usage/cmd/tftpsrv.rst b/doc/usage/cmd/tftpsrv.rst
index 2c6d08cdc80..c71702953ca 100644
--- a/doc/usage/cmd/tftpsrv.rst
+++ b/doc/usage/cmd/tftpsrv.rst
@@ -30,8 +30,8 @@ file is passed to bootm after the transfer completes. Otherwise, the command
 returns without booting the file; boot scripts can use commands such as
 bootm, booti or bootefi to boot from the load address.
 
-The transfer is aborted if no transfer has started after about 50 seconds or
-if Ctrl-C is pressed.
+If no transfer starts after about 50 seconds, *netretry* controls whether
+the command retries or aborts. Ctrl-C always aborts the command.
 
 Example
 -------
diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index a2c82ababd9..e742273bee1 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -67,17 +67,6 @@
 #define TFTP_ERROR 5
 #define TFTP_OACK  6
 
-enum tftp_error {
-  TFTP_ERROR_FILE_NOT_FOUND    = 1,
-  TFTP_ERROR_ACCESS_VIOLATION  = 2,
-  TFTP_ERROR_DISK_FULL         = 3,
-  TFTP_ERROR_ILLEGAL_OPERATION = 4,
-  TFTP_ERROR_UNKNOWN_TRFR_ID   = 5,
-  TFTP_ERROR_FILE_EXISTS       = 6,
-  TFTP_ERROR_NO_SUCH_USER       = 7,
-  TFTP_ERROR_OPTION_NEGOTIATION = 8
-};
-
 #include <string.h>
 
 struct tftp_req {
@@ -181,7 +170,7 @@ static void
 transfer_timed_out(void)
 {
   LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout\n"));
-  tftp_state.ctx->error(tftp_state.handle, -1, tftp_timeout_msg,
+  tftp_state.ctx->error(tftp_state.handle, TFTP_ERROR_TIMEOUT, tftp_timeout_msg,
                         sizeof(tftp_timeout_msg) - 1);
   close_handle();
 }
@@ -295,7 +284,7 @@ send_error_and_close(const ip_addr_t *addr, u16_t port,
 {
   send_error(addr, port, code, str);
   if (tftp_state.handle != NULL)
-    tftp_state.ctx->error(tftp_state.handle, code, str, strlen(str));
+    tftp_state.ctx->error(tftp_state.handle, TFTP_ERROR_LOCAL, str, strlen(str));
   close_handle();
 }
 
@@ -1087,7 +1076,11 @@ start_send_requests(const ip_addr_t *addr, u16_t port, u16_t opcode, const char*
   tftp_state.port = 0;
   tftp_state.retries = 0;
   ret = resend_request();
-  if (ret != ERR_OK) {
+  /* A route or device send failure must not bypass the request retry timer.
+   * Keep allocation and invalid-request errors terminal at setup time.
+   */
+  if ((ret != ERR_OK) && (ret != ERR_RTE) &&
+      (ret != ERR_IF) && (ret != ERR_ABRT)) {
     clear_req();
     ip_addr_set_any(0, &tftp_state.addr);
     tftp_state.handle = NULL;
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
index 092e7d4059a..4445f551166 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
@@ -50,6 +50,20 @@
 extern "C" {
 #endif
 
+/* Negative callback errors are not TFTP wire error codes. */
+enum tftp_error {
+  TFTP_ERROR_LOCAL            = -2,
+  TFTP_ERROR_TIMEOUT          = -1,
+  TFTP_ERROR_FILE_NOT_FOUND    = 1,
+  TFTP_ERROR_ACCESS_VIOLATION  = 2,
+  TFTP_ERROR_DISK_FULL         = 3,
+  TFTP_ERROR_ILLEGAL_OPERATION = 4,
+  TFTP_ERROR_UNKNOWN_TRFR_ID   = 5,
+  TFTP_ERROR_FILE_EXISTS       = 6,
+  TFTP_ERROR_NO_SUCH_USER      = 7,
+  TFTP_ERROR_OPTION_NEGOTIATION = 8
+};
+
 /** @ingroup tftp
  * TFTP context containing callback functions for TFTP transfers
  */
@@ -87,7 +101,7 @@ struct tftp_context {
   /**
    * Error indication from client or response from server
    * @param handle File handle set by open()/tftp_get()/tftp_put()
-   * @param err error code from client or server
+   * @param err A negative tftp_error value, or the peer's wire error code
    * @param msg error message from client or server
    * @param size size of msg
    */
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 41ea12ed486..9e19857d19b 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -46,6 +46,7 @@ struct tftp_ctx {
 	bool upload;
 	bool wrq_accepted;
 	u32 listen_retries;
+	bool retry;
 	char fname[TFTP_MAX_FILENAME_LEN + 1];
 };
 
@@ -188,7 +189,7 @@ static void tftp_close(void *handle)
 static int tftp_complete(struct tftp_ctx *ctx, ulong addr, const char *fname)
 {
 	if (ctx->done != SUCCESS)
-		return -EIO;
+		return ctx->done == FAILURE && ctx->retry ? -EAGAIN : -EIO;
 	if (!ctx->upload && env_set_hex("fileaddr", addr)) {
 		log_err("fileaddr not updated\n");
 		return -EIO;
@@ -252,6 +253,12 @@ static void tftp_error(void *handle, int err, const char *msg, int size)
 	char message[100];
 
 	ctx->done = FAILURE;
+	/* Match the legacy client's server-error and retry-exhaustion policy.
+	 * Local validation and memory-write failures must not be retried.
+	 */
+	ctx->retry = err == TFTP_ERROR_TIMEOUT ||
+		(err >= 0 && err != TFTP_ERROR_FILE_NOT_FOUND &&
+		 err != TFTP_ERROR_ACCESS_VIOLATION);
 	memset(message, 0, sizeof(message));
 	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
 
@@ -480,6 +487,7 @@ static void no_request(void *arg)
 
 	printf("Timeout!\n");
 	ctx->done = FAILURE;
+	ctx->retry = true;
 }
 
 static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
@@ -572,10 +580,20 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (tftpsrv_loop(&net, laddr) < 0)
-		ret = CMD_RET_FAILURE;
-	else
+	net_try_count = 1;
+	net_restart_wrap = 0;
+	for (;;) {
+		ret = tftpsrv_loop(&net, laddr);
+		if (ret != -EAGAIN)
+			break;
+		puts("Starting again\n\n");
+		ret = net_lwip_restart(&net);
+		if (ret)
+			break;
+	}
+	if (!ret)
 		image_load_addr = laddr;
+	ret = ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 
 out:
 	net_lwip_stop(&net);
@@ -594,10 +612,10 @@ static void tftp_default_filename(struct net_lwip_ctx *net, char *fname,
 	printf("*** Warning: no boot file name; using '%s'\n", fname);
 }
 
-static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[], enum tftp_operation operation)
+static int do_tftp(int argc, char *const argv[], enum tftp_operation operation)
 {
-	struct net_lwip_ctx net = {};
+	struct net_lwip_ctx local = {};
+	struct net_lwip_ctx *net = &local;
 	u32 timeout_msecs = UBOOT_TFTP_TIMEOUT_MS;
 	u32 max_retries = UBOOT_TFTP_MAX_RETRIES;
 	int ret = CMD_RET_SUCCESS;
@@ -767,27 +785,38 @@ static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out;
 	}
 
-	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT)) {
+	if (net_lwip_start(net, NET_LWIP_ADDR_ENV_STRICT)) {
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
+	net_try_count = 1;
+	net_restart_wrap = 0;
 
-	if (tftp_check_ip(&net)) {
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-	if (!fname || !*fname) {
-		tftp_default_filename(&net, default_fname, sizeof(default_fname));
-		fname = default_fname;
+	for (;;) {
+		ret = tftp_check_ip(net);
+		if (ret)
+			break;
+		/* Rotation may select an interface with a different IP address. */
+		if (!fname || !*fname)
+			tftp_default_filename(net, default_fname, sizeof(default_fname));
+		ret = tftp_loop(net, operation, laddr, size,
+				fname && *fname ? fname : default_fname, srvip,
+				port, srcport, timeout_msecs, max_retries);
+		if (ret != -EAGAIN)
+			break;
+		/* The failed transfer's PCB and timers are already gone. Never
+		 * change interfaces underneath another shared-runtime client.
+		 */
+		puts("Starting again\n\n");
+		ret = net_lwip_restart(net);
+		if (ret)
+			break;
 	}
-
-	if (tftp_loop(&net, operation, laddr, size, fname, srvip,
-		      port, srcport, timeout_msecs, max_retries) < 0)
-		ret = CMD_RET_FAILURE;
-	else if (operation == TFTP_DOWNLOAD)
+	if (!ret && operation == TFTP_DOWNLOAD)
 		image_load_addr = laddr;
+	ret = ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 out:
-	net_lwip_stop(&net);
+	net_lwip_stop(net);
 	free(arg_copy);
 	return ret;
 }
@@ -796,7 +825,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret;
 
-	ret = do_tftp(cmdtp, flag, argc, argv, TFTP_DOWNLOAD);
+	ret = do_tftp(argc, argv, TFTP_DOWNLOAD);
 	if (ret || !net_boot_file_size)
 		return ret;
 	/* The transfer's callbacks and runtime attachment are already gone. */
@@ -805,5 +834,5 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 int do_tftpput(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	return do_tftp(cmdtp, flag, argc, argv, TFTP_UPLOAD);
+	return do_tftp(argc, argv, TFTP_UPLOAD);
 }
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
index 7d84120ab4c..66f43e9c553 100644
--- a/test/dm/lwip_tftp.c
+++ b/test/dm/lwip_tftp.c
@@ -30,6 +30,7 @@ struct tftp_protocol_test {
 	unsigned int server_phase;
 	int error;
 	int read_error;
+	err_t send_error;
 	bool initialized;
 	bool fail_data_alloc;
 	bool window_requested;
@@ -73,7 +74,7 @@ static err_t tftp_test_output(struct netif *netif, struct pbuf *p,
 					  offset + sizeof("timeout"));
 	}
 	test->sent++;
-	return ERR_OK;
+	return test->send_error;
 }
 
 static void tftp_test_close(void *handle)
@@ -200,7 +201,7 @@ static int tftp_test_oack(struct unit_test_state *uts,
 		ut_assertok(tftp_test_start(test, false));
 		memcpy(packet + 2, invalid[i], lengths[i]);
 		ut_assertok(tftp_test_input(test, packet, lengths[i] + 2, 0));
-		ut_asserteq(8, test->error);
+		ut_asserteq(TFTP_ERROR_LOCAL, test->error);
 		ut_asserteq(1, test->closed);
 		ut_asserteq(5, test->opcode);
 	}
@@ -218,7 +219,7 @@ static int tftp_test_oack(struct unit_test_state *uts,
 	/* A write request without tsize must reject an unsolicited tsize. */
 	ut_assertok(tftp_test_start(test, true));
 	ut_assertok(tftp_test_input(test, valid, sizeof(valid), 0));
-	ut_asserteq(8, test->error);
+	ut_asserteq(TFTP_ERROR_LOCAL, test->error);
 	return 0;
 }
 
@@ -314,7 +315,7 @@ static int tftp_test_data_alloc_retry(struct unit_test_state *uts,
 	test->read_error = -EIO;
 	timer_test_add_offset(40);
 	sys_check_timeouts();
-	ut_asserteq(2, test->error);
+	ut_asserteq(TFTP_ERROR_LOCAL, test->error);
 	ut_asserteq(1, test->closed);
 	ut_asserteq(1, test->reads);
 	sent = test->sent;
@@ -474,12 +475,66 @@ static int tftp_test_stale_control(struct unit_test_state *uts,
 		ut_assertok(tftp_test_input(test, invalid, sizeof(invalid), 0));
 		ut_asserteq(5, test->opcode);
 		ut_asserteq(8, test->block);
-		ut_asserteq(8, test->error);
+		ut_asserteq(TFTP_ERROR_LOCAL, test->error);
 		ut_asserteq(1, test->closed);
 	}
 	return 0;
 }
 
+static int tftp_test_request_send_errors(struct unit_test_state *uts,
+					 struct tftp_protocol_test *test)
+{
+	static const err_t errors[] = { ERR_RTE, ERR_IF, ERR_ABRT, ERR_MEM, ERR_ARG };
+	static const u8 data[] = { 0, 3, 0, 1, 'x' };
+	static const u8 ack[] = { 0, 4, 0, 0 };
+	int i, put, exhaust;
+	err_t ret;
+
+	for (put = 0; put < 2; put++) {
+		for (exhaust = 0; exhaust < 2; exhaust++) {
+			for (i = 0; i < ARRAY_SIZE(errors); i++) {
+				if (test->initialized)
+					tftp_cleanup();
+				memset(test, 0, sizeof(*test));
+				ipaddr_aton("1.1.2.2", &test->server);
+				ut_assertok(tftp_init_client(&tftp_test_callbacks));
+				test->initialized = true;
+				test->send_error = errors[i];
+				ut_assertok(tftp_set_timeout(30, 1));
+				if (put)
+					ret = tftp_put(test, &test->server, 69, "file",
+						       TFTP_MODE_OCTET);
+				else
+					ret = tftp_get(test, &test->server, 69, "file",
+						       TFTP_MODE_OCTET);
+				ut_asserteq(i < 3 ? ERR_OK : errors[i], ret);
+				ut_asserteq(1, test->sent);
+				if (!exhaust)
+					test->send_error = ERR_OK;
+				timer_test_add_offset(31);
+				sys_check_timeouts();
+				ut_asserteq(i < 3 ? 2 : 1, test->sent);
+				ut_asserteq(0, test->error);
+				if (i >= 3)
+					continue;
+				if (exhaust) {
+					timer_test_add_offset(31);
+					sys_check_timeouts();
+					ut_asserteq(TFTP_ERROR_TIMEOUT, test->error);
+					ut_asserteq(1, test->closed);
+				} else {
+					ret = tftp_test_input(test, put ? ack : data,
+							      put ? sizeof(ack) : sizeof(data), 0);
+					ut_assertok(ret);
+					ut_asserteq(0, test->error);
+					ut_asserteq(put ? 3 : 4, test->opcode);
+				}
+			}
+		}
+	}
+	return 0;
+}
+
 static int tftp_test_timeout_range(struct unit_test_state *uts,
 				   struct tftp_protocol_test *test)
 {
@@ -549,7 +604,7 @@ static int tftp_test_timeout_option(struct unit_test_state *uts,
 				/* Reject unrequested or non-echoed timeout values. */
 				ut_assertok(tftp_test_input(test, bad, sizeof(bad), 0));
 			}
-			ut_asserteq(8, test->error);
+			ut_asserteq(TFTP_ERROR_LOCAL, test->error);
 			ut_asserteq(1, test->closed);
 		}
 	}
@@ -641,7 +696,7 @@ static int tftp_test_windows(struct unit_test_state *uts,
 		ut_assertok(tftp_test_start_window(test, false, 4));
 		ut_assert(test->window_requested);
 		ut_assertok(tftp_test_input(test, bad[i], bad_len[i], 0));
-		ut_asserteq(8, test->error);
+		ut_asserteq(TFTP_ERROR_LOCAL, test->error);
 		ut_asserteq(1, test->closed);
 	}
 	ut_assertok(tftp_test_start_window(test, false, 4));
@@ -706,7 +761,7 @@ static int tftp_test_windows(struct unit_test_state *uts,
 	ut_assertok(tftp_test_start_window(test, false, 1));
 	ut_assert(!test->window_requested);
 	ut_assertok(tftp_test_input(test, one, sizeof(one), 0));
-	ut_asserteq(8, test->error); /* Unrequested option. */
+	ut_asserteq(TFTP_ERROR_LOCAL, test->error); /* Unrequested option. */
 
 	ut_assertok(tftp_test_start_window(test, false, 65535));
 	ut_assertok(tftp_test_input(test, rollover, sizeof(rollover), 0));
@@ -872,6 +927,8 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 		ret = tftp_test_duplicate_oack(uts, &test);
 	if (!ret)
 		ret = tftp_test_stale_control(uts, &test);
+	if (!ret)
+		ret = tftp_test_request_send_errors(uts, &test);
 	if (!ret)
 		ret = tftp_test_timeout_range(uts, &test);
 	if (!ret)
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index 62a0a887150..e5589b19f27 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -46,11 +46,28 @@ struct tftp_test_context {
 	ulong ack_start;
 	ulong ack_delay;
 	unsigned int advertised_timeout;
+
 	char filename[64];
+	char first_filename[64];
 	struct in_addr local_ip;
+	bool default_filename;
 	u16 blocksize;
 	u16 windowsize;
 	u16 port;
+	unsigned int drop_requests;
+	unsigned int send_errors;
+	unsigned int error_requests;
+	u16 error_code;
+	bool invalid_oack;
+	bool partial;
+	unsigned int server_ticks;
+	unsigned int server_attempt;
+	unsigned int server_phase;
+	unsigned int server_acks;
+	unsigned int failed_attempts;
+	unsigned int server_case;
+	int server_error;
+	unsigned int timeout_ticks;
 };
 
 static ulong tftp_test_option(const char *packet, size_t len, const char *option)
@@ -96,7 +113,8 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	struct tftp_test_context *ctx = priv->priv;
 	struct ethernet_hdr *eth = packet, *reply_eth;
 	struct ip_udp_hdr *ip, *reply_ip;
-	const char *data = ctx->fail ? "not found" : tftp_test_data;
+	bool fail = ctx->fail || ctx->error_requests;
+	const char *data = fail ? "error" : tftp_test_data;
 	unsigned int data_len = ctx->empty ? 0 : strlen(data) + 1;
 	unsigned int reply_len, header_len = 4;
 	u16 opcode, reply_opcode = 3, block = 1;
@@ -133,6 +151,10 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	if (ip->ip_p != IPPROTO_UDP)
 		return 0;
 	opcode = get_unaligned_be16(ip + 1);
+	if (opcode == 4 && ctx->probe == TFTP_PROBE_NONE) {
+		ctx->server_acks++;
+		return 0;
+	}
 	if (opcode == 4 && ctx->probe >= TFTP_PROBE_DATA) {
 		ctx->probe_acks++;
 		if (ctx->probe_acks == 1) {
@@ -148,7 +170,13 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 
 		if (!ctx->requests++)
 			ctx->request_start = get_timer(0);
+		if (ctx->send_errors) {
+			ctx->send_errors--;
+			return -EIO;
+		}
 		strlcpy(ctx->filename, (char *)(ip + 1) + 2, sizeof(ctx->filename));
+		if (ctx->requests == 1)
+			strlcpy(ctx->first_filename, ctx->filename, sizeof(ctx->first_filename));
 		ctx->local_ip = ip->ip_src;
 		ctx->blocksize = tftp_test_option((char *)(ip + 1), request_len, "blksize");
 		ctx->windowsize = tftp_test_option((char *)(ip + 1), request_len, "windowsize");
@@ -169,19 +197,32 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 				"timeout\0" "1" : "timeout\0" "5";
 			data_len = 10;
 		}
+		if (ctx->requests <= ctx->drop_requests)
+			return 0;
+		if (ctx->error_requests)
+			ctx->error_requests--;
 		if (opcode == 2) {
 			reply_opcode = 4;
 			block = 0;
 			data_len = 0;
+		} else if (ctx->partial && ctx->requests == 1) {
+			partial = true;
+			data_len = 512;
 		}
 	} else if (ntohs(ip->udp_dst) == 1234 && opcode == 3 &&
 		   len >= ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 4) {
 		reply_opcode = 4;
 		block = get_unaligned_be16((u8 *)(ip + 1) + 2);
 		data_len = 0;
+		if (ctx->partial && ctx->requests == 1)
+			return 0;
 	} else {
 		return 0;
 	}
+	if (fail)
+		block = ctx->fail ? 1 : ctx->error_code;
+	if (ctx->invalid_oack)
+		data_len = 0;
 	reply_len = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + header_len + data_len;
 	if (priv->recv_packets >= PKTBUFSRX)
 		return -ENOSPC;
@@ -205,7 +246,7 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	reply_ip->udp_len = htons(UDP_HDR_SIZE + header_len + data_len);
 	reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
 	payload = (void *)(reply_ip + 1);
-	put_unaligned_be16(ctx->fail ? 5 : reply_opcode, payload);
+	put_unaligned_be16(ctx->invalid_oack ? 6 : fail ? 5 : reply_opcode, payload);
 	if (header_len == 4)
 		put_unaligned_be16(block, payload + 2);
 	if (partial)
@@ -409,39 +450,281 @@ static int tftp_test_options(struct unit_test_state *uts,
 }
 #endif
 
-static int tftp_test_protected_autostart(struct unit_test_state *uts,
-					 struct tftp_test_context *ctx)
+#if IS_ENABLED(CONFIG_NET_LWIP)
+static void tftp_test_tick(void *arg)
+{
+	struct tftp_test_context *ctx = arg;
+
+	ctx->timeout_ticks++;
+	timer_test_add_offset(5001);
+	sys_timeout(1, tftp_test_tick, arg);
+}
+
+static int tftp_test_retry_command(struct tftp_test_context *ctx, bool put)
+{
+	int ret;
+
+	sys_timeout(1, tftp_test_tick, ctx);
+	if (ctx->default_filename)
+		ret = run_command(put ? "tftpput 2000000 20" : "tftpboot 2000000", 0);
+	else
+		ret = run_command(put ? "tftpput 2000000 20 update.bin" :
+				  "tftpboot 2000000 update.bin", 0);
+	sys_untimeout(tftp_test_tick, ctx);
+	return ret;
+}
+
+static int tftp_test_restarts(struct unit_test_state *uts,
+			      struct tftp_test_context *ctx)
 {
+	static const char * const policies[] = { NULL, "no", "once", "2", "yes" };
+	struct net_lwip_ctx shared = {};
 	char * const argv[] = { "tftpboot", "2000000", "update.bin" };
-	int enabled, helper, ret;
+	int i, put, ret;
 
-	for (enabled = 0; enabled < 2; enabled++) {
-		ut_assertok(env_set("autostart", enabled ? "yes" : "no"));
-		ut_assertok(env_set(".flags", "autostart:br"));
-		for (helper = 0; helper < 3; helper++) {
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("tftptimeout", NULL));
+	ut_assertok(env_set("tftptimeoutcountmax", NULL));
+	ut_assertok(env_set("netretry", "no"));
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->drop_requests = UINT_MAX;
+	ut_asserteq(CMD_RET_FAILURE, tftp_test_retry_command(ctx, false));
+	ut_asserteq(CONFIG_NET_RETRY_COUNT * 2 + 1, ctx->requests);
+	ut_asserteq(0, net_boot_file_size);
+
+	ut_assertok(env_set("tftptimeout", "1000"));
+	ut_assertok(env_set("tftptimeoutcountmax", "0"));
+	for (put = 0; put <= IS_ENABLED(CONFIG_CMD_TFTPPUT); put++) {
+		for (i = 0; i < ARRAY_SIZE(policies); i++) {
 			memset(ctx, 0, sizeof(*ctx));
-			switch (helper) {
-			case 0:
-				ret = tftpb_run(TFTP_TEST_ADDR, "update.bin");
-				break;
-			case 1:
-				ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
-				break;
-			default:
-				ret = tftpb_run_argv(3, argv);
-			}
-			/* Do not override protection when suppression is required. */
-			ut_asserteq(enabled, !!ret);
-			ut_asserteq(!enabled, ctx->requests);
-			ut_assert(!ctx->autostart);
-			ut_asserteq_str(enabled ? "yes" : "no", env_get("autostart"));
+			ctx->drop_requests = 2;
+			ut_assertok(env_set("netretry", policies[i]));
+			ret = tftp_test_retry_command(ctx, put);
+			ut_asserteq(i < 3 ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+			ut_asserteq(i < 2 ? 1 : i == 2 ? 2 : 3, ctx->requests);
+			ut_asserteq(-ENODEV, net_lwip_poll());
 		}
-		ut_assertok(env_set(".flags", NULL));
+		for (i = 0; i <= 8; i++) {
+			memset(ctx, 0, sizeof(*ctx));
+			ctx->error_requests = 1;
+			ctx->error_code = i;
+			ut_assertok(env_set("netretry", "once"));
+			ret = tftp_test_retry_command(ctx, put);
+			ut_asserteq(i == 1 || i == 2 ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+			ut_asserteq(i == 1 || i == 2 ? 1 : 2, ctx->requests);
+		}
+		/* Exhaust packet retries after a device send failure, then restart. */
+		for (i = 0; i < 2; i++) {
+			memset(ctx, 0, sizeof(*ctx));
+			ctx->send_errors = 1;
+			ut_assertok(env_set("netretry", i ? "once" : "no"));
+			ret = tftp_test_retry_command(ctx, put);
+			ut_asserteq(i ? CMD_RET_SUCCESS : CMD_RET_FAILURE, ret);
+			ut_asserteq(i + 1, ctx->requests);
+		}
+		/* A failed transfer with progress must start from the beginning. */
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->partial = true;
+		ut_assertok(tftp_test_retry_command(ctx, put));
+		ut_asserteq(2, ctx->requests);
+		ut_asserteq(put ? 32 : sizeof(tftp_test_data), net_boot_file_size);
+		if (!put)
+			ut_asserteq_mem(tftp_test_data, map_sysmem(TFTP_TEST_ADDR, 0),
+					sizeof(tftp_test_data));
+	}
+	/* Invalid options and metadata publication failures are not peer errors. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->invalid_oack = true;
+	ut_asserteq(CMD_RET_FAILURE, tftp_test_retry_command(ctx, false));
+	ut_asserteq(1, ctx->requests);
+	memset(ctx, 0, sizeof(*ctx));
+	ut_assertok(env_set(".flags", "filesize:xr"));
+	ret = do_tftpb(NULL, 0, ARRAY_SIZE(argv), argv);
+	ut_assertok(env_set(".flags", NULL));
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_asserteq(1, ctx->requests);
+
+	/* A second runtime user must survive a request to rotate interfaces. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->error_requests = 1;
+	ctx->error_code = 3;
+	ut_assertok(net_lwip_start(&shared, NET_LWIP_ADDR_ENV_STRICT));
+	ret = do_tftpb(NULL, 0, ARRAY_SIZE(argv), argv);
+	i = net_lwip_poll();
+	net_lwip_stop(&shared);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_assert(i >= 0);
+	ut_asserteq(1, ctx->requests);
+
+	/* Retry on the next sandbox interface, not on the failed one. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->drop_requests = 1;
+	ut_assertok(env_set("ethrotate", NULL));
+	ut_assertok(env_set("ipaddr5", "1.1.2.4"));
+	ut_assertok(env_set("netmask5", "255.255.255.0"));
+	ut_assertok(tftp_test_retry_command(ctx, false));
+	ut_asserteq(2, ctx->requests);
+	ut_asserteq_str("eth@10003000", env_get("ethact"));
+	ut_asserteq_str("update.bin", ctx->filename);
+	ut_asserteq(string_to_ip("1.1.2.4").s_addr, ctx->local_ip.s_addr);
+	ut_assertok(env_set("bootfile", NULL));
+	for (put = 0; put <= IS_ENABLED(CONFIG_CMD_TFTPPUT); put++) {
+		ut_assertok(env_set("ethact", "eth@10002000"));
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->default_filename = true;
+		ctx->drop_requests = 1;
+		ut_assertok(tftp_test_retry_command(ctx, put));
+		ut_asserteq(2, ctx->requests);
+		ut_asserteq_str("01010203.img", ctx->first_filename);
+		ut_asserteq_str("01010204.img", ctx->filename);
 	}
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("tftptimeout", NULL));
+	ut_assertok(env_set("tftptimeoutcountmax", NULL));
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_NET_LWIP)
+#if IS_ENABLED(CONFIG_CMD_TFTPSRV)
+static int tftp_test_server_packet(const void *data, size_t len)
+{
+	struct udp_pcb *pcb;
+	struct pbuf *p;
+	ip_addr_t peer;
+
+	for (pcb = udp_pcbs; pcb; pcb = pcb->next)
+		if (pcb->local_port == 69 && pcb->recv)
+			break;
+	if (!pcb)
+		return -ENOENT;
+	p = pbuf_alloc(PBUF_RAW, len, PBUF_RAM);
+	if (!p)
+		return -ENOMEM;
+	pbuf_take(p, data, len);
+	ipaddr_aton("1.1.2.2", &peer);
+	pcb->recv(pcb->recv_arg, pcb, p, &peer, 1234);
+	return 0;
+}
+
+static void tftp_test_server_tick(void *arg)
+{
+	static const char wrq[] = "\000\002file\000octet";
+	u8 data[4 + 512] = { 0, 3, 0, 1 };
+	struct tftp_test_context *ctx = arg;
+	bool fail = net_try_count <= ctx->failed_attempts;
+
+	ctx->server_ticks++;
+	if (ctx->server_attempt != net_try_count) {
+		ctx->server_attempt = net_try_count;
+		ctx->server_phase = 0;
+	}
+	if (!ctx->server_phase && (!fail || ctx->server_case)) {
+		ctx->server_error = tftp_test_server_packet(wrq, sizeof(wrq));
+		ctx->server_phase++;
+	} else if (ctx->server_phase == 1 && (!fail || ctx->server_case > 1)) {
+		if (!fail) {
+			memcpy(data + 4, tftp_test_data, sizeof(tftp_test_data));
+			ctx->server_error = tftp_test_server_packet(data,
+								    4 + sizeof(tftp_test_data));
+		} else if (ctx->server_case == 2) {
+			/* Retain a full block before forcing a restart. */
+			memset(data + 4, 0xee, 512);
+			ctx->server_error = tftp_test_server_packet(data, sizeof(data));
+		} else {
+			put_unaligned_be16(5, data);
+			put_unaligned_be16(ctx->error_code, data + 2);
+			ctx->server_error = tftp_test_server_packet(data, 5);
+		}
+		ctx->server_phase++;
+	}
+	timer_test_add_offset(5001);
+	sys_timeout(1, tftp_test_server_tick, ctx);
+}
+
+static int tftp_test_server_run(struct tftp_test_context *ctx)
+{
+	int ret;
+
+	sys_timeout(1, tftp_test_server_tick, ctx);
+	ret = run_command("tftpsrv 2000000", 0);
+	sys_untimeout(tftp_test_server_tick, ctx);
+	return ret;
+}
+
+static int tftp_test_server_policy(struct unit_test_state *uts,
+				   struct tftp_test_context *ctx)
+{
+	static const char * const policies[] = { "no", "once", "2", "yes" };
+	struct net_lwip_ctx shared = {};
+	unsigned int retries = CONFIG_NET_RETRY_COUNT * 2;
+	int scenario, i, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("ethrotate", "no"));
+	/* These client settings must not change the server's compiled defaults. */
+	ut_assertok(env_set("tftptimeout", "1000"));
+	ut_assertok(env_set("tftptimeoutcountmax", "0"));
+	ut_assertok(env_set("netretry", "no"));
+	for (scenario = 0; scenario < 2; scenario++) {
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->server_case = scenario;
+		ctx->failed_attempts = UINT_MAX;
+		ut_asserteq(CMD_RET_FAILURE, tftp_test_server_run(ctx));
+		ut_assertok(ctx->server_error);
+		ut_asserteq(1, ctx->server_attempt);
+		ut_asserteq(retries + 1, ctx->server_ticks);
+		ut_asserteq(scenario ? retries + 1 : 0, ctx->server_acks);
+		ut_asserteq(0, net_boot_file_size);
+	}
+	/* Exhaust listening, accepted-WRQ and partial-DATA retries in turn. */
+	for (scenario = 0; scenario < 4; scenario++) {
+		for (i = 0; i < ARRAY_SIZE(policies); i++) {
+			memset(ctx, 0, sizeof(*ctx));
+			ctx->server_case = scenario;
+			ctx->failed_attempts = 2;
+			ctx->error_code = 3;
+			ut_assertok(env_set("netretry", policies[i]));
+			ret = tftp_test_server_run(ctx);
+			ut_assertok(ctx->server_error);
+			ut_asserteq(i < 2 ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+			ut_asserteq(i < 2 ? i + 1 : 3, ctx->server_attempt);
+			ut_asserteq(i < 2 ? 0 : sizeof(tftp_test_data), net_boot_file_size);
+			if (i >= 2)
+				ut_asserteq_mem(tftp_test_data, map_sysmem(TFTP_TEST_ADDR, 0),
+						sizeof(tftp_test_data));
+		}
+	}
+	ut_assertok(env_set("netretry", "once"));
+	for (i = 1; i <= 2; i++) {
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->server_case = 3;
+		ctx->failed_attempts = 1;
+		ctx->error_code = i;
+		ut_asserteq(CMD_RET_FAILURE, tftp_test_server_run(ctx));
+		ut_asserteq(1, ctx->server_attempt);
+	}
+	/* Do not rotate a runtime still held by another client. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->server_case = 3;
+	ctx->failed_attempts = 1;
+	ctx->error_code = 3;
+	ut_assertok(net_lwip_start(&shared, NET_LWIP_ADDR_ENV_STRICT));
+	ret = tftp_test_server_run(ctx);
+	i = net_lwip_poll();
+	net_lwip_stop(&shared);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_assert(i >= 0);
+	ut_asserteq(1, ctx->server_attempt);
+
+	ut_assertok(env_set("tftptimeout", NULL));
+	ut_assertok(env_set("tftptimeoutcountmax", NULL));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("ethrotate", NULL));
+	return 0;
+}
+#endif
+
 static int tftp_test_addresses(struct unit_test_state *uts,
 			       struct tftp_test_context *ctx)
 {
@@ -461,6 +744,12 @@ static int tftp_test_addresses(struct unit_test_state *uts,
 		ut_asserteq_str("01010204.img", ctx->filename);
 		ut_asserteq(string_to_ip("1.1.2.4").s_addr, ctx->local_ip.s_addr);
 	}
+#if IS_ENABLED(CONFIG_CMD_TFTPSRV)
+	memset(ctx, 0, sizeof(*ctx));
+	ut_assertok(tftp_test_server_run(ctx));
+	ut_assertok(ctx->server_error);
+	ut_asserteq(sizeof(tftp_test_data), net_boot_file_size);
+#endif
 	/* A valid global address must not hide an unset/invalid indexed one. */
 	ut_assertok(env_set("ipaddr", "1.1.2.3"));
 	for (i = 0; i < 2; i++) {
@@ -470,6 +759,9 @@ static int tftp_test_addresses(struct unit_test_state *uts,
 		ut_asserteq(CMD_RET_FAILURE, ret);
 		ut_asserteq(0, ctx->requests);
 		ut_asserteq(0, net_boot_file_size);
+#if IS_ENABLED(CONFIG_CMD_TFTPSRV)
+		ut_asserteq(CMD_RET_FAILURE, run_command("tftpsrv 2000000", 0));
+#endif
 	}
 	ut_assertok(env_set("ethact", "eth@10002000"));
 	ut_assertok(env_set("ethrotate", NULL));
@@ -508,12 +800,57 @@ static int tftp_test_zero_address(struct unit_test_state *uts,
 		ut_asserteq(1, ctx->requests);
 		ut_asserteq(32, net_boot_file_size);
 	}
+#if IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_CMD_TFTPSRV)
+	memcpy(saved, buffer, sizeof(saved));
+	memset(ctx, 0, sizeof(*ctx));
+	sys_timeout(1, tftp_test_server_tick, ctx);
+	ret = run_command("tftpsrv 0", 0);
+	sys_untimeout(tftp_test_server_tick, ctx);
+	memcpy(received, buffer, sizeof(received));
+	memcpy(buffer, saved, sizeof(saved));
+	ut_assertok(ret);
+	ut_assertok(ctx->server_error);
+	ut_asserteq(0, env_get_hex("fileaddr", 1));
+	ut_asserteq_mem(tftp_test_data, received, sizeof(received));
+#endif
 	unmap_sysmem(buffer);
 	ut_assertok(env_set("loadaddr", "2000000"));
 	image_load_addr = TFTP_TEST_ADDR;
 	return 0;
 }
 
+static int tftp_test_protected_autostart(struct unit_test_state *uts,
+					 struct tftp_test_context *ctx)
+{
+	char * const argv[] = { "tftpboot", "2000000", "update.bin" };
+	int enabled, helper, ret;
+
+	for (enabled = 0; enabled < 2; enabled++) {
+		ut_assertok(env_set("autostart", enabled ? "yes" : "no"));
+		ut_assertok(env_set(".flags", "autostart:br"));
+		for (helper = 0; helper < 3; helper++) {
+			memset(ctx, 0, sizeof(*ctx));
+			switch (helper) {
+			case 0:
+				ret = tftpb_run(TFTP_TEST_ADDR, "update.bin");
+				break;
+			case 1:
+				ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+				break;
+			default:
+				ret = tftpb_run_argv(3, argv);
+			}
+			/* Do not override protection when suppression is required. */
+			ut_asserteq(enabled, !!ret);
+			ut_asserteq(!enabled, ctx->requests);
+			ut_assert(!ctx->autostart);
+			ut_asserteq_str(enabled ? "yes" : "no", env_get("autostart"));
+		}
+		ut_assertok(env_set(".flags", NULL));
+	}
+	return 0;
+}
+
 static int tftp_test_download(struct unit_test_state *uts,
 			      struct tftp_test_context *ctx)
 {
@@ -538,8 +875,13 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(tftp_test_protected_autostart(uts, ctx));
 
 #if IS_ENABLED(CONFIG_NET_LWIP)
-	ut_assertok(tftp_test_addresses(uts, ctx));
+	if (IS_ENABLED(CONFIG_NET_TFTP_VARS))
+		ut_assertok(tftp_test_restarts(uts, ctx));
 	ut_assertok(tftp_test_options(uts, ctx));
+#if IS_ENABLED(CONFIG_CMD_TFTPSRV)
+	ut_assertok(tftp_test_server_policy(uts, ctx));
+#endif
+	ut_assertok(tftp_test_addresses(uts, ctx));
 #endif
 	ut_assertok(tftp_test_filenames(uts, ctx));
 	ut_assertok(tftp_test_zero_address(uts, ctx));
@@ -721,6 +1063,13 @@ static int dm_test_tftp_download_only(struct unit_test_state *uts)
 	sandbox_eth_set_priv(0, NULL);
 	sandbox_eth_set_tx_handler(1, NULL);
 	sandbox_eth_set_priv(1, NULL);
+#if IS_ENABLED(CONFIG_NET_LWIP)
+	sys_untimeout(tftp_test_tick, &ctx);
+#if IS_ENABLED(CONFIG_CMD_TFTPSRV)
+	sys_untimeout(tftp_test_server_tick, &ctx);
+#endif
+#endif
+	env_set(".flags", NULL);
 	image_load_addr = saved_load_addr;
 	memcpy(net_boot_file_name, saved_bootfile, sizeof(saved_bootfile));
 	for (i = 0; i < ARRAY_SIZE(vars); i++) {

-- 
2.53.0

