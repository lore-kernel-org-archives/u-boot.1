Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF3606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i0U1gu55;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wS0p2WOv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00DCE8104C;
	Tue, 24 Nov 2026 13:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-mQsXhtEm9P; Tue, 24 Nov 2026 13:23:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 593698104D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526586;
	b=VyuwWllverQwKKYxaceyRh96gLGeqGLEc1FHCcmU0F6KDQ50tiCR1PUwfTKfu09rXOej
	 g0Fiovh2CxMKoyDZn0+xNmLXpNh5SAbeNXppkB4zM9B5AvFy6yOBL6vpQ3hCQNKtgC57K
	 QbT03KKa9skSKrN6HoKIMPq/S1l7SfNYIHJfTD3fBWChFQPh1FH79EbE32Vlfvew4EK49
	 Gu59Poz/0BWiX1B23ZKh9aUzrQpUcUvlWqjXwUlFR+ZlFxrpaSTGEG73ZROgMfCX41wrB
	 uMyAhXpn4MkAuKVqTZR9qrJGeZxMYz4j+Ba24rAQNQAXYFJWW46n73NnCuz/oERIokw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yU4xAesailw5WjOibJdLOwRGqTXFJmA+nXG/kebO1Cc=;
	b=OQHGmCn2SKViJbrpvUGr3R+LzcEuk4B/PouWjqchUS9hEzvYbz4Sy7PILM1FyeZxAaf2
	 /VmtB4WB+lhuku2NvhWeZpkzJ2zHaXABYrt2LaCW1Rly6X6b2gryCbEqK6VXVKNG+QTNs
	 Ctdd56Rfbh+uTQTWAnslW+Jpd442xzSw8uUn140sK84GoibH1qtCr46PtBO/tku9BH0jk
	 /wIiwGSGhLjhxZ7cT/yoa9SOeXDBvPOVdwzK8Msxuvdft09QFA6G16LSTXa9a77F/fjmS
	 1xK5NKNuSWDz3a5uyqVyihpzDsLHryn9yA4mAf+p51RNhfYnkUc+3xBSZyZNhZc6IRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526586;
	bh=yU4xAesailw5WjOibJdLOwRGqTXFJmA+nXG/kebO1Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i0U1gu55dM2Yj6vPL5/wgxSumhnUEsyRfQcvczAO0fkTrN7HCn1zpK6hnIuIm4Jas
	 OM0QyaecVCMA+VQSUEUJ6JgvjHFsR/H9TPM3tZ0teVLYlzzWmpcHuFsS/JqkcwinPo
	 6Lig5u8e+M2QLPD7HXEtmw643a3jG5g9GiQbsPvjhiPg6WlDkQcvX4pqixy6AbKTXm
	 RB3YqHzhuGSHJGzocZhCClWMjgnFLbcXokcDRQqddK3HCot4qRpgb+4EHjC3+dgG+1
	 9KtNXWPKJzQ0dyk52JogJ9qBlHTz9yvDPVHNOPrXm917SBGNTldq3is0aURKIq7Sf3
	 16X/3ReQ8XrLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 593698104D;
	Tue, 24 Nov 2026 13:23:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71EE71AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E4B040243
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1eSFoHiGKxYC for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 11:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3447240116
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com;
 envelope-from=ssunkkan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=wS0p2WOv
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3447240116
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:33:44 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso2205583b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795520024; x=1796124824;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yU4xAesailw5WjOibJdLOwRGqTXFJmA+nXG/kebO1Cc=;
 b=wS0p2WOvqxgwqp0yWN5mCaVJ3BhAIH1oLAnI936nd6IefOYrCDxBJY1Q3HXnVsiHmM
 11m3FCvF1AH3VgVITrEIOD87Lc6JZXbgLPRsIddB9TZEtXcX85ZupYZYVUP6VR2xV3eS
 sY+DVhRjxgxOt7u4HTs9AUt0rPJm3d8OeeJLcqED8JW5WY88DKD9g/20F6RUsqIwvjDp
 kAAyYLWTiijZKzaKHDFKkit8raYtGbKDl7RXVkMhAiUMkZGwqTN0wkn2EGeSyvt7Ylmu
 FfmOEPQkzFPIYiT0howtby3WWMfkhPdI4QLxDZUqOeHeC6txkxnFlvHYYPpGJ1A3aVb5
 D4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520024; x=1796124824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yU4xAesailw5WjOibJdLOwRGqTXFJmA+nXG/kebO1Cc=;
 b=R977NrGMpvwKoFlnCZXzgvckgKSvbhzF1mSN4jNTVjx2RHQIsPzVfDPkCR5Ij865eg
 62XP9cpgjgb4XjJOLlHdfz89aIZB5+gs7Q2MR4YXPIPLtuTySfN1S0BVxifRKz0Ecm6A
 dbmWX8b9iaizuj0yyJKtwav1ueYroKTeHwwkUo6Ya2rmxG78zQVVZDoYW/bb1PNQxuHi
 59lnZYal+9jJ75B06SUoXrCtfuyo0LqarzzPJgigYS8hB5dylc0EGD/TB6i1Y1b+XgE8
 hxNGCTZL6X06UCviAt6Yui6oj1OOgjrtO8T/AWenjufLULe1k6Z/FY7ZxUkzQNS3lzJP
 ddmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFqZwP+68qUFEj7Tw5ncSgeRlXhNL+yuH7qEAAhlAKBSH6GbMYS9RJCMaJBn0En8r/DsJg4NPE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+EDONsBo1ll/oBd3G9zveVcMUn3UB1H6/xJh6GcsgV6We1j7Ls
 CCbq322PuKq9cEf6wZ9bdqGaoqOFPXwOqYgR8Vzd1gLhBe8TF2px/CA4
X-Gm-Gg: AZFdTZdi9bxxK4JU5LLFxay5tt0evbP++yKiK8Z/Fy5QvQ60TWQhQGS6P52DyaxNFCi
 KmVlYpAto75f0Z6k6JB90pWofpulBMZvMoKZcskuTAuc237G76g8bcLY2luu0OH2B2ITez3VMuX
 kpjE20QZeM4Mlgl6TRUjbAhjH4wevKZeet6Zk2noXThEA48WShJHdUetK6p/TAY3rjkVZ6if0uZ
 DRyK/SFGV0U9F699JQX6RLZZyZIQnHv3UGQ03/Bu+pB58c7BosCK0m0AjfKdOOCwWbyip5KXdZG
 1AXG8ej15qOalUzjUqXuH2vmWuKSGqYy32WLyZioLVo7RBA+zmS5kZ3gJfUOvnB4rDLBYFOOAp9
 Rg1neWVeEwL1GzMIrJ7RIxo8Nk0GlPOVDAx2JPW0dS7BUoOZ5PjlkkjBjxdxUqZGwP28wxeuuax
 RV99LBhf7Wdx/HjvBoccjaL9OCPfjrMY16FzKrBF9bdy0zuETY5rBc1YhVYYLpUvob255LvjpL8
 mMdNYZCITVXk/vducALD2sdTg8/vFXr+uCbgxS/wOwsp/ZjF/3+UvEx9C9T9B1RC8sqOlsJX7Ri
 306qRqBybmrhGSRUBe9IrlZ3
X-Received: by 2002:a05:6a21:7704:b0:3dd:a197:735a with SMTP id
 adf61e73a8af0-4014de5ba0cmr13772862637.51.1795520023921; 
 Tue, 24 Nov 2026 03:33:43 -0800 (PST)
Received: from Sun ([240e:3a2:dcf:f2e0:b166:f710:8cf3:4924])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d002a77sm6591288a12.16.2026.11.24.03.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:33:43 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: takahiro.kuwano@infineon.com
Cc: Jacky_guo@xmcwh.com, u-boot@lists.u-boot-project.org, vigneshr@ti.com,
 hs@nabladev.com, Ssunk <ssunkkan@gmail.com>
Subject: Re: [PATCH] mtd: spi: spi-nor-ids: Add support for XMC XM25QU01D
Date: Tue, 24 Nov 2026 19:33:36 +0800
Message-ID: <20261124113336.1793-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
In-Reply-To: <0b5e6c2475e44574a61c5692d9ac13d3@infineon.com>
References: <0b5e6c2475e44574a61c5692d9ac13d3@infineon.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Takahiro,=0D
=0D
Sorry for the delayed response, and thanks for your review.=0D
=0D
> Please use Link: tag.=0D
=0D
Will do in v2.=0D
=0D
> Did you test in Quad mode? Current driver assumes Quad input page=0D
> program is supported if SPI_NOR_QUAD_READ is set.=0D
> I don't see Quad input page program with 4B address (34h) in the datashee=
t.=0D
=0D
Yes, I have tested Quad mode, including the 4-byte Quad Page Program=0D
command (34h), and confirmed that it works correctly.=0D
=0D
The latest datasheet provided directly by XMC confirms support for=0D
command 34h. The datasheet currently available on their website is=0D
an older revision.=0D
=0D
According to XMC, their online documentation is updated quarterly,=0D
and the revised datasheet will be available in a future update.=0D
=0D
Thanks,=0D
Ssunk=
