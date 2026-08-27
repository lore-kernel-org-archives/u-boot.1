Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFADC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 23:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 757AB80EFB;
	Thu, 27 Aug 2026 23:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuUe0E-bpS3Y; Thu, 27 Aug 2026 23:53:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787874836;
	bh=VQwpo7/E2v9iUOez641lI4SvUfSB4O/FPZiB7j2f/fk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SbJhvkKzLwuLyGsBHJBXuiDH2/fHUOx+dD4mSgUGkamAbRgY1IqVFb2SaZsEjOUCB
	 ZNo+kLtYXjz02bEZcCyGbBz2OkI55w2dauryPNMANvyTr56pJ0dvdnRGRsy+132ELG
	 +GabftIDBJV55NqDz/JFtNkzX4qmyK7Ns4KNV8bl8wP046/kfAZZvyY2DzzR3JmnHH
	 REaxlqTC7FZilHloqK5sTuAetfVaZmEmdE3a29jW27PS1Pbw66cY59LOc7JrXYCOXf
	 9wm0YCrWZCW5qHs9oYHfg0IE3vNcI5UAaJlWntYfqKm0DNKGEv7kwhjee78ChYP2/m
	 QwCeyHlDruUvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 236AF80EFD;
	Thu, 27 Aug 2026 23:53:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F393355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 23:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30BA840786
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 23:53:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jzsrCvVwNlp for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 23:53:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pPeBnjO6
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AA4040816
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 23:53:52 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-836cb2fa1bcso2613707b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787874831; x=1788479631;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQwpo7/E2v9iUOez641lI4SvUfSB4O/FPZiB7j2f/fk=;
 b=pPeBnjO6jiiFqA78A8ZKS9I1wozX/Ov+emjzeu7+d2CDCejOftCVyCuhZP1i7Djnsx
 l8SG00IO92hudAv9XUd1cw1J7p3kk8Kd0tVC3ZeKdwH/hCiJFkJx0BkXRDXRXXAVj0Zy
 xG3TSc/OKylcgmxiwds7c4HhCaB2M8EvUwnhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787874831; x=1788479631;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VQwpo7/E2v9iUOez641lI4SvUfSB4O/FPZiB7j2f/fk=;
 b=bbsYRt4l02PXqjDzHhWRJyQ8sD3TQjXBekR7bBtb7HbyurjePeMmaTSPN0fLCb7L12
 4qJxF2ir1HsdC52VbEw2C2UEDkDNLsR6YzJvSacIxKw8+bdzHahZ1Q3VaqTUVdj05qvm
 Ky0R1IyG3+mnoXrm8HkPvRPKZ0Uki1n7ir8djhyk6PMi6NQY4ZHQ/7C8RiN98Yg22SsH
 iwb1ngzRU9dH8RcYy89PXMkHQ9RCOETYUaH9LnCO9AIpOxbAIy7zTmMjyNb7mmOL79H5
 3G7KcHKUH7C9RJLUeaTkHO5FW3VNCmbQYChw2G5CdW5hden78oW+HpltIBi4w7VUF/MR
 /1hQ==
X-Gm-Message-State: AFuF++nuCSPCivVX80vZcztzPG4NyPfP0vvUjR1lIj/zfFF0mJAbC/IL
 oYrXS0QbnEjU6dX+KsjmnN2jIK+AM6pl1Pe/7QwtnAhDu/zQ4FhzFfEenAM6ZyydAuE=
X-Gm-Gg: AR+sD12eoza8a2gQqtrXHOjOcnGyktpOzYMrvrdIT82fnT5RZNpUBBJudhTwh8xtLic
 UDEZZRbmWecdY3HRykPcBawtAX3MztBumsPhnEujbb1PI0Uokv5E4EiOPg/Qk+DkdusbqbLMXBg
 dFOiaxC0dLRoiLKIkAzgUxZBYWlILqcQa1IkeRC46LKSoAMeYeQ9/y6nEegdThjCYL7JK4BQR5c
 UMurKnFc2DOor7fo/msXyyNDALHWFImgC5y2Vj8cOE3wx8Wm6Mcy6KdWkiCsrgTu7YShm1VY9Wh
 q7mzmheuTQJ/NJoN7SBobYOagcynU7LjiyMYIuSOeiz0Z4HcrhUUl7lF+Px8nqYc1qnJfetOw1N
 uqt5lFX3JeXKNvXx4B4Eutrv2V+i4SJ9HJ7NfoKieiKTo3eCPOamkSjxDyr0UuPgBYoZkrbyrmi
 YIPrNTpRjpIV+fMXIlsE154vPyRMsEM2DBAN07SdQUKPCKZURf+gJJ1TOFapk8n52BD/puViksl
 wrtjqyaIIv623lOw6VF9rRtjjUPZaOmt/ZP/+5dTlu18N+CqCIZwxWqIkFZCnt+9unowAvknOTi
 QK/EtaFd
X-Received: by 2002:a05:690c:c513:b0:858:def3:3422 with SMTP id
 00721157ae682-85d6eff4d34mr15009657b3.27.1787874831655; 
 Thu, 27 Aug 2026 16:53:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b5c603753sm18626277b3.12.2026.08.27.16.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 16:53:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Pranav Rajendran <pranavkasthuri@gmail.com>
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com, 
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
In-Reply-To: <20260815220115.11335-1-pranavkasthuri@gmail.com>
References: <20260815220115.11335-1-pranavkasthuri@gmail.com>
Subject: Re: [PATCH v1 0/2] fs/squashfs: bounds checks on image-controlled
 offsets
Message-Id: <178787483023.52175.17385631781199807900.b4-ty@konsulko.com>
Date: Thu, 27 Aug 2026 17:53:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 15 Aug 2026 23:01:13 +0100, Pranav Rajendran wrote:

> Two out-of-bounds reads reachable from a crafted SquashFS image, found
> while auditing fs/squashfs for image-controlled values used as buffer
> offsets without validation. Both were reported to the list earlier; these
> are the fixes.
> 
> Patch 1 covers sqfs_frag_lookup(), where the fragment index is checked
> only against a superblock field that is itself part of the image, and
> every subsequent access derived from it is unchecked against the buffer
> that was actually read.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] fs/squashfs: bound fragment table accesses in sqfs_frag_lookup()
      commit: fc557ef9fe116b3245265629cf1d3ab4ac7a480c
[2/2] fs/squashfs: bound the offset returned by sqfs_dir_offset()
      commit: e007b43a272edae8a63ad66f0151ceaf8cf003c1
-- 
Tom


