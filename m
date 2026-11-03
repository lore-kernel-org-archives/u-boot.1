Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC43606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NE64IE6f;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhpVgAxf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B91AC6060A;
	Tue,  3 Nov 2026 07:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aOK_AzZwRdnE; Tue,  3 Nov 2026 07:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08C5460769
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689979;
	b=bl8KfoM3ouqUlqUXmQmZRqd6fSBUi37aSBanXqxpi5LcYmC7h+XRsY/+UUvp0RTMiKdU
	 SrZyfkSbPD+mwMvLwQ83OcqoNpbyowHTniSMam8x67rZGAj8spN6QVEZ11bBfbncRVZPL
	 /7qvECt873gyVmyF5OGUxU/Pmxj1ZJF9jnIxr8NQWlUeDrrtMIkxocJVR99KQGcJbSsaT
	 qMk+QBHfOOt1EYgl7lqUV45olDwUDHGtYRRSVlbvle6dAgoJyzpt3dD9q0GfdZv+2kolU
	 HdM7WK1Y1z9hFuA9V+WesEIcXCoexNveqpiQ1y6GixuXT69c8g6bHLmdza6OKyxG0Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kF7pn6Tk3aKMk4DaSzudlxezLtWgu07Up4xOZcU11qs=;
	b=fL9dpyho8+roLH9pFfUmM0C1bscNNCOawhmjNmj9OmsWW11yk2AEgHSZAO4nC+G7IroP
	 D3hRAI4m83314KYjAILedEmRlOVUmH/BUhFDjM8EGMLHvqzaQ8NDT7dkC5vKEjo8157/Y
	 5e6JskYlIfkqLMv6lKbiAoa2x3A5SowZsoWZznoI1YcmSoPoKmogXfactk86NNLI5oxKO
	 crPjV2d2sQCLta2NcF6DVVvipcUH/OxbFTIqn7IwoIxru9Fca0Pha64dlrm3LWHC9zmfS
	 phPMtuYtW6eK5+IF+9W57vXnmdUC9kP28cOJ2vpTobpPjrBSSd8JXNazKVo1A9aYbjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689979;
	bh=kF7pn6Tk3aKMk4DaSzudlxezLtWgu07Up4xOZcU11qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NE64IE6fwSMHqXoN2X3orR7on1IMf1y2iLF5tAoKI7bYK+pmcni8WKP9yF5MjVOn2
	 mIkY+mjPO+DgOybzxMZxC02Q2jkEwO2JB+LuWqsA4qKqOc9CmwfGRoXaAIZV1kZqYT
	 XOkCCuUWM7ihU9FBOi1csippgg9bJmK/BFxvqw1rrQZiIqo6DjamZsvObrGHXCXKNI
	 spsQPqCr6cTHaKfiikr4qw9aZGuaQx/TBskLXYeXnvAW42xFuFAc+a3N9mxBMka5N/
	 1Q5iAqeLwlZaoescE9Wnb6rTnooprftKFPyGKuFeNZB6xZTC+vJA17J/cEvPGWvjVV
	 EFHWz0k725hXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08C5460769;
	Tue,  3 Nov 2026 07:12:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 550B0411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5266580E21
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7qrgI3EDWWJQ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52D5B80D81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793689976;
 b=V9IBMxHMTDgaW/F4nNf3HAOIv5bBNQiRJa5YLa7esBA1TAIVSAyEoAhWjqa9nN2cplZk
 LBPrfZB7y/Z2sZKySlJWY5NNGfI9ZK6Rc0fPvc6/vuvT6822yXa6IncF1nHx+8JgCvwsP
 pOzoa/flV2M2uGVqYwBHrX7fYU1N9jJjBS9Gs0D40ph/r2RAd6AJDN4g1cd/wf4JvSWaY
 EzHx52OitZ6PGZmlt2CPKi9x7xgerQgMUpjmUql6Sn4iGipF536e2u5oFsK69eMD11Cpl
 HGW/dYbkbvZM+yM4CyjdGWvEiEN6Octe1qPRI+AKW3N0mUUX9FYmQ4AVYPM5C5zX1iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689976;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=kF7pn6Tk3aKMk4DaSzudlxezLtWgu07Up4xOZcU11qs=;
 b=ZroHLQARdTSTzLCAKLXLVsnDHK8VUbq3RfeoRMnnvTNMaDICbQmNHXvhDoHvGFghcHUP
 7B80NE4LSJfcXkSu4n/F2vaSNw92aGfDHxZ2PPXN+tE+Wxp9/iMsmUmJt+8p68Atu0in+
 dVyUncbYVWIzaLiC1frs9cqDgEBmDHusn3xwvEkPoyjIJC0l6MLkZlVgsLZbgIJZ689XC
 ToryFvfK66kvklSWSqqdWoEOQNl7NkZaolZhKFY0zMlEv1a2xd8wDDpwrpo7xNwflcOSA
 3Kxym/heUDbriYuv1EJLvPWVOGlXU9nhHabztzeo/a+xm9jBdsbK/Bz10aCiHIo1FhA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EhpVgAxf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EhpVgAxf
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52D5B80D81
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:54 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so1682515e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793689973; x=1794294773;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kF7pn6Tk3aKMk4DaSzudlxezLtWgu07Up4xOZcU11qs=;
 b=EhpVgAxfER1DySMNfJj99Mil+i/OlUHEmp9iPZHnXx/GfliNDVgkOs1w4J95MnEfNH
 hwBPC3JcU9JLYW91UNgUQ+0AX6J2cFSFDCXNSYKrrChMDSRvxPXRjTqcHWxYloZzA2DR
 W5laStTORdW0v9y/D09ItScuyYE5spgMBlDDC7qV7BwHmQX9SzEPf7nW82gYhUSlodwb
 NFrD2GTeOulWNHEhYZ5i2Y+afOoJfIRFi5C3Ji9RdIEcfUTP/eblk+sBra3cresRQ24T
 T49vE5Rb/3mTrfKaU2I+R+lf3xq2P9qtbWXLq2et3iVVZqaLAt1hIWjOAy//0RTAhuVO
 B2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689973; x=1794294773;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kF7pn6Tk3aKMk4DaSzudlxezLtWgu07Up4xOZcU11qs=;
 b=Muo1J/3NoV6qiqfudCJaV0dA/W+wfEgdfRZ50GjJ2tZLwWssarqlNXD0+VPtQUrlSo
 RDOENqAIEfEguQFEtzP8e1KdufOpPqjRZI4mxgGSS15HhEgKu11DXj/sBFqYQRwPLALN
 uSvA8Ay3LExLkGpvx/cYdZB2y1nfgCF+JHETUBoo9uU0N2KOJC8bS5APgRev4pHzaUWn
 Qm5v/TaWZU6ZgnybNrRIP1gl+bcv/OJBA719iIY8S/ziB6k8gBlcKDhUGNWvz6DZo1wX
 wdub4J13VwaV9vdg+n4pegKpv9BKOSSzH0T8t66F1G9rSaDL73ZvJyxD1CfxzLXoMZoP
 +6fA==
X-Gm-Message-State: APuU4Z/p30+ULM72OHKdsUf23XhJiLVoTmRA90RTzWxKiggQmRdlppww
 9U9bwhDwR3/vtJrqf+16e6s50jtlsxpLh+uJqkqwe598AuZXzUYjvhgrdXQvMRn5kaA35yfK
X-Gm-Gg: AYBFou1zJ65103DeT+lIvuwVhwuB+1S+qCr/DSP7L+bSUtZhwUMsIm99952eJ2LNKT7
 LGRN/WTJQk0AoIJ6bo9X8wKHrXoOLMdy20jOICMKWTgL/AZhLZTfIAXzMRT1SepJV0/Rc0anviO
 AwXUPiunzZ9DzZtYCWmW2MEpthIGlAwa49DF5A+MZMEFI6yFacmYCIZJqBIEqMDdkxRgp06TZcB
 f079ZscfJFi0AfisXN1x8WtnVuaBxFV/GnqWs0ursoRTHv4PDvEFdw4wahlx9PPCkbJLRykl7QL
 G4zkzurxBfb4IrJ5N/Vm/merj06ZGhPaH5iA7zdlXgZj1HXVAFn/lJW9bItXyIRfiVSW24Pw/VR
 UUcJ3BvsraN2lU3+Amu4CqaAVp2ghUjEcrCUPqBIHKHu0s9NlnmIFjJjvltyNNGe6ND31vo6DLx
 f1eMTEbIpoc3S9uYUSccogC5aRqGUmD/fb7M2tfyWi/PzMN9/KLy5owg/NCnIZUf5MNWPDJXIZp
 xCWWn2hHcYAwd8Vtp91YA4w7knmSuHplETqwHBdya1z5BuvqePUyWil1kaiNNEUED1D50EccQ+8
 7jW5uyn+DUfBY8GSdWOm1BrNEc7GQvE=
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ac17567fe1mr287497625e9.12.1793689972831; 
 Mon, 02 Nov 2026 23:12:52 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm34585715e9.5.2026.11.02.23.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:12:52 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>, Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 2/6] mtd: ubispl: check data_size before loading a LEB
Date: Tue, 03 Nov 2026 07:12:51 +0000
Message-ID: <0390b590-ff95-4f34-a7f0-833ab417292b@gmail.com>
In-Reply-To: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

ubi_load_block() reads data_size bytes of a PEB to the load address and
computes the data CRC over them, with data_size taken from the block's
VID header. The SPL loader checks the header's magic, CRC and used_ebs
but not data_size, so a header claiming more data than a LEB holds makes
the loader read past the end of the PEB and write beyond the part of the
load buffer that LEB is meant to fill.

Treat a block whose data_size exceeds the LEB size as corrupt, as is
done when the data CRC does not match: the loader then looks for another
copy of the LEB and, if none is found and fastmap was used, retries with
a full scan. Each LEB now adds at most one LEB to the loaded image.

Fixes: 6f4e7d3c75a8 ("spl: Lightweight UBI and UBI fastmap support")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/mtd/ubispl/ubispl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
index 0143caa051d..0466cc72c9e 100644
--- a/drivers/mtd/ubispl/ubispl.c
+++ b/drivers/mtd/ubispl/ubispl.c
@@ -964,6 +964,18 @@ retry:
 	 */
 	dlen = be32_to_cpu(vh->data_size);
 
+	/*
+	 * A data_size beyond the LEB is never valid: reading it would run
+	 * past the PEB and past this LEB's part of the load buffer. Treat
+	 * the block as corrupt and look for another copy.
+	 */
+	if (dlen > ubi->leb_size) {
+		ubi_warn("Vol: %u LEB %u PEB %u bad data_size %u", vol_id,
+			 lnum, pnum, dlen);
+		generic_set_bit(pnum, ubi->corrupt);
+		goto find_other;
+	}
+
 	/*
 	 * Read the data into RAM. We ignore the return value
 	 * here as the only thing which might go wrong are
