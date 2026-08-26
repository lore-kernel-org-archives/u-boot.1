Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9A8C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 14:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 123CA40522;
	Wed, 26 Aug 2026 14:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1TEh8hIOyRmR; Wed, 26 Aug 2026 14:58:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787756320;
	bh=XHyZaoxWyh1AEGuy6jvqeekuLyFu9He4pX6z4xuu/JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=L0uex2RAVz4vd5GTd7Yg2x9RE33xM4oKwL052hazYcd7Z6Xzm/3Em8UYmseYvUQfr
	 R0AQmFdXWZ2OmhF1VOQUddbHQw064tyJtSV7kxZXl7QAxw+fG22c7+AUG/Z0IN+LJd
	 5em7t/vvQYPVV83lbaLgvxNegwvWp07SJ5p/2h4jr9qQzzWvsT+ygvqg/QglR6v8ny
	 dDp+xWO48peInzqUrY7otWCec5KJ1/Vf2busGfD83QQl5tsOmOPSIBtjEhcm+XJs4+
	 axZX7ES+WLMQ/U3oFUera0J3bf4dtbwoYzb/sfeEr48HWVBEWoNCbUEMtRrIhtOPOJ
	 AULr+xNr/D/FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78DF440511;
	Wed, 26 Aug 2026 14:58:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18526323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F27F040525
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id butfbPFcKEzp for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 14:26:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=srherobrine20@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fSQxJrO1
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E32940475
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:26:24 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d6b5aa7535so10475225ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787754384; x=1788359184;
 darn=lists.u-boot-project.org; 
 h=content-type:content-transfer-encoding:mime-version:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XHyZaoxWyh1AEGuy6jvqeekuLyFu9He4pX6z4xuu/JA=;
 b=fSQxJrO1g4R46h80wqvFrVkx1TDVwi9/70HWImD85IsLl+aqKo/gN1ZZF8Z6kipiEd
 6nblXsQYaGfqK+wj2vrW8OF7w85zMm+Lk4OzaqwIqllqord/T2PLhCTVfO9+xJflt5w7
 B+tcWMH1LQ3WmVsz77qYEgEk56qVbFMeb2ecLW4O8lmU6iUt42Ef1pJ8Zk8PAOscpELT
 U4X8Uz4LhPZvVcqjkxxrliTF8DyJXbjqtmJOav3c/iveOwr3+BuqEB14MAQJB+S/FoRe
 q+OY/juTtM7cu/kCM6x/K0bcoeWDvGRq1rn2dzDmz5WV7J9hPLs0v05/xCos1jCJSJ2n
 V7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787754384; x=1788359184;
 h=content-type:content-transfer-encoding:mime-version:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XHyZaoxWyh1AEGuy6jvqeekuLyFu9He4pX6z4xuu/JA=;
 b=o6SeZnBHPEt9+qhYHFvE18Y+Fb0Ga0hnm/zJL2ZJt7qNxA1KcCjceWeoCR2/RD5LWK
 uDbfAMfS9bsr+SEaCfZYWOw32xpYlbS3zlQwbFlaLWmJCvTpXumSXZuP5Y6p7CaZRH5u
 2OOJNWxVLcezaU35q9PvJD3l7AiFiyvJQA+4Vls9GOMaz0oRkxPZQtGtwLMjn1UIw0eZ
 NILHLNHQi6JfbDkm56OpOk448XPOqOGEBlcGXIIpLivYgM9yHxn/BXqDZzWZkjT9sz9x
 u6C/bbEy05BvjApt2Dah+bN0f1N7S25KdbDjyf9hUNIhnLuEuAeUzXlpCWqB5KRDP2pe
 ceUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAxhCzj+GN+CX1QRHKxa+lofeivM2H2hdK6fy18t9bd/SrBw1S2ctMzm5GAxVxdTcZXAFfMbA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kh3weqli8iwDZDjyJs/hWjzpkmamug+WED5PVGCNy33XyCepXN
 Ck1TxNcN2XYmZcrX2TCvr7IhUIq+10TQvFHo9tOIGY+hIVauuFpmkUM=
X-Gm-Gg: AR+sD13W0CmW4YAmA9sMH9EN4lojLhmF5Uk/vMNtqrewnKoD+IAX0UYW6vlFVuQLQxd
 ZyVIpVpKtQVnsiq9nm2zRTwU5ZIjPsiL9aVq7gum4qMd8aJW6NyEx1j4RldlFiixtfAg8lmxPXg
 Lpp14Ts9jMJ9nDWlzarJM3JP9ffYRxuCsV5MdNlptZGf9iA3rDC+alckKTSh8BvU5tJITa93xRX
 2pBMpCFF4pyScw2weacMzuNtgGEKITVgztzKup4S/LIO0rIAa/bgKkOZwnDxRdVoWrljQxWCisQ
 LKrdBrtjvAZ1pqODsqCHp3X4M3awK2qmIQbxGzc4C36tctjPzaE0Gnl8cGy5A9mPmE/ImmOeFXV
 5cV+8zgdvlGfCg1hafxTS3eNIHVkgsQMqeQ6lEFQekoI5rr7V0d5G4ByAK5weuqreZS3kOeyew2
 ZWK/WATbQ7NNY42xCgv6IHu1MfgZb63drSUzrYpv3y3idpNkR/IIYy2nbG2H9yqv9zsg4pCajuB
 SpIW6CvBmXholVCjwE6+BnAytwVIWPnskM1Sj7qupPJD+ss
X-Received: by 2002:a17:902:cf41:b0:2d0:401c:2ebb with SMTP id
 d9443c01a7336-2d7079df723mr150930455ad.4.1787754383766; 
 Wed, 26 Aug 2026 07:26:23 -0700 (PDT)
Received: from matheus-note.localnet ([2804:7f0:84b3:2201:fb27:8354:17d:2bcc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d8c4e56sm8474202eec.22.2026.08.26.07.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 07:26:23 -0700 (PDT)
From: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
To: maskachoska@yahoo.com
Cc: ansuelsmth@gmail.com, daniel.schwierzeck@gmail.com,
 dario.binacchi@amarulasolutions.com, frieder.schrempf@kontron.de,
 jerome.forissier@arm.com, marex@denx.de, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 00/12] mips: add EcoNet/Airoha EN75xx (EN7512/EN7528)
 SoC support
Date: Wed, 26 Aug 2026 11:26:18 -0300
Message-ID: <kSKs4kbLRy20mVMgtwFdmg@gmail.com>
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Wed, 26 Aug 2026 14:58:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Dude, if you're going to get other people's patchers and not even mention that someone else used the base, don't even send the patchers, I just made a draft for the SoC en751221 and en7528, on the openwrt forum itself I said that the boot was unstable, especially the ethernet of the en7528 and the spi0


