Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3F606A32C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DvCW93vu;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LJutsTsX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8197D81184;
	Wed,  4 Nov 2026 23:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmalEW-aYPsN; Wed,  4 Nov 2026 23:54:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D38A281185
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793836457;
	b=ljry8aaqCYB+eH8rZz5Mh7dJN8+58J07tJzWD7AOx9STLIIjgtQZ06nJDjQmuYKY/tcr
	 L6v6C8sWnH4tLSF6qGCG8g7DrffauNtw413l1/bDOE+2KOXy3SWSAmKBbMMyzVMm6zJOE
	 bZGcd9hfU0eM7WppPxnocRPDRTNvG2w5zI0lyR+Ce8RA6Do/SBgHATgKMpcfPeoC/EedL
	 gK1bSG9dcmB3T9jsTFKs/RWrWpurQ4iZY5LdL8qCTw6YZIyVv4y6Vzcarhp8mPBE20qmr
	 fouHo19dSAKqf4YrGaeNmXmwCm/RILAyIbzA2aDjJkM5b8C14IIhtxJvl1v8/s+Vdog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793836457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gKsgXOzB52nnKGSQ85khxFdcY1ex4XCWfYjj05MSiFE=;
	b=rxD6Q1+dmm0C3lcTtbr0UMG8qZg4VRHJadqD6IFy1roiDpz8xCXm6N5hjkmeJZBniTXO
	 stoTX/lp1oUqZhVUe+8vtbbatxMBuvyIggfedDxGfsijoXyY50wN4KbVg7u4qRLElpFeW
	 SZGJUrkNaX0r3sU9gXsRC3kAxmOvH8hJHdhXlbZDKrGf3LsuZhdodgtYMAlU7/D+5nBbN
	 1bq3Qivarcf6BLZ05PWph6uQZMiOGS2jcHaJPinnD+IReMP+uFy0P5aD4OtyCr1Po4ji7
	 aVHmM8xheabgNDYYnFkrh6p26AphxjQjNV1+yZ7KBgmLW9+IZPIN9ZbtLRHSlV1Eegw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LJutsTsX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793836457;
	bh=gKsgXOzB52nnKGSQ85khxFdcY1ex4XCWfYjj05MSiFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DvCW93vuFCu7lXGQ0o3AXjMbEcj4Dp4k8MG9UAhXnfEcH491aVbgDfQKmCNYVPN3B
	 525iIkBgQUWlYqiWJg3YRDOZcUZ+uepXgaWNj7FK2j6mQydz8RSXlC4BkGTMlL5lkE
	 84IoSfPXekIc5OLbPzuoI78OufaC/zQZXuipJhKB3HJ6ucTS4tIb/KhNQROn3Z/zJ2
	 kfshzN13jQ7v1F+0/4HKB0kg7MaFDuJ4dOwrhAQy+v1Ubq3TXSBeRZEO0E8iYGxT4W
	 32X6IP2AbI96ue3mtHrBT8H7L61w2M1lChmpOrLkOEzq8VES8tzQjYGFZ+rChdYpy9
	 4kaO31OoqKzvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D38A281185;
	Wed,  4 Nov 2026 23:54:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CBDB362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 23:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DD4081185
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 23:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpOKqtiGJysI for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 23:54:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E77881184
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LJutsTsX
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E77881184
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 23:54:14 +0000 (UTC)
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3535a54bed9so1709385eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 15:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793836453; x=1794441253;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gKsgXOzB52nnKGSQ85khxFdcY1ex4XCWfYjj05MSiFE=;
 b=LJutsTsXOyVGGIUHWSVBDt48iDbttlDguBZIcwnJJktuUx0sNOzV/R/3B+s9biR0aF
 I0Rj0UrUs2qEBp33J5gvHQ9soEiDqrYBH1Q4vyGg2lOlfleX/184wJiXJyDN1vGXwh1V
 80K6nAXAWGkUSnpKWSaVmXxcU+r3vOCjIwBru/zyesPAQByfxI296yS9laJCzg9GWDaz
 GLswkLH9pUkgkYLAfW1nUeJeqSgo20Kb43PV8OHHG7tCFMTTym+jjUxSE5YhA0rMufgy
 Ey5QSjVY7N6IkL3Pe4Fq6Xx1rWPcKcM7XgZAF1JPQ2tY68KA1bn1jTG4CFCzIyN5rG63
 K0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793836453; x=1794441253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gKsgXOzB52nnKGSQ85khxFdcY1ex4XCWfYjj05MSiFE=;
 b=El0KJ725VqCDdQFduEC/ng8dKyHFio+6ctLsy5G4Sv2GPRA3NvF1jYQWwCeeYqjg07
 T2BYDxPh8Q7xtBUK1YG2pCtVzwltjwsGpjIUbbm+LI8HBC2i67c5Oy+6DT3obYO2BsSE
 3q8j98/MxppE8/mnnlnHBeefygnb1cFf/bwLWpQGvuOkatHxjTKUXWS4RbFHeg+VqkpD
 UqqFX7yD4iNprVFXd+XjUXIMiHcHvXnKb0hfgHx7tVNapFUm8fWr0NRxPZvcWj+KKco+
 se5tJ+IXLv+Tuberinrzeb3fKjX87xxy2/EwWywbWsDVK9VivuvL9gsfbw5QtgnbwyJf
 LBgA==
X-Gm-Message-State: APuU4Z+/6ggBmthDOFpfURBZnrbocxu0inue5h95TE1OkTW01X+heStl
 ab1Nh75dJtSyC8KyzLjwZ0GKhA+9vrd/MoYKsnCCD+mAQPgF53takkj/
X-Gm-Gg: AYBFou0vK1kcJtPs8QB3BYzcrNOnUUYtZXbnlAiLDgwHYBGLvI8suqmTRBzKUgbHFJm
 lBfUhqHL8pFVLyxAS0wk97aI3vP7Q3qbAEig6U9Fh3ydo9+5tPCYEa/0gDrSMH+NnWOiQfgNrHk
 xI1EK7nVafngKlXHwXp49Ap0+iin956onB0EVaCrdmvq3gof/fkdcMB0A1O+zTkxWfNbt38cawF
 LwReZYzFaUpqOx/Bnnkq3OGetjogPl5cRSFDzowGBw1wyRDtf9FnFQEDNgvlBS2fw/4l0nVqKZe
 YfCMAVjEQVK/WpuyVUrHBXN+MgTgXRzD+iU8nx2YjPM89IjFEOoXeZU6wsUUDFFGw01vOoHAMuH
 kl/fSY0w7k31rGEN0udatFHVEn4Ir4Piy+6IGEO25hMrBtqmbgWOw6psnMBtd+wY6YHMCt/CXLz
 qIAoHIdFz/iJmGjv/AQarnoAD7Di/YyDlD7yZ5DbSLOSxta97lL/6iC8bWHiwvvRp+pFqvyQszb
 PVqa3usZLJQnwGJaDWLuxNx53Jzc/BX278yo6XpP3X9jjOhY8Hhe5lywXZhVPm58Bu2jGXwQsaE
 Tr4YqVBxEuZ4kC8vWvbxK7K47EAu99zutc+Tv9UT2IUEFhYbVypm0bXBWPYPUEB517zm1r+nqG9
 tFQjRaFksj4qoZ2+dpKsM7ogTKp8k/BFWSaTcNuJIAP3Eau2QLTyvrLewOBbSO99JOBlv7TN7LY
 Iv+qSvhuErvZ4ZevfxwkxFH8HTLmibDw==
X-Received: by 2002:a05:7301:4e8a:b0:36d:9322:b7fe with SMTP id
 5a478bee46e88-36d9331fd06mr3441152eec.29.1793836453122; 
 Wed, 04 Nov 2026 15:54:13 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3785430sm16039568eec.3.2026.11.04.15.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 15:54:12 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 visitorckw@gmail.com, xypron.glpk@gmx.de
Subject: Re: [PATCH v6 6/6] doc: virtio: Explain how to reach the virtio RTC
Date: Thu,  5 Nov 2026 07:54:08 +0800
Message-ID: <20261104235408.2655998-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTi20S-CDj+MrZR5LmfJ-0cvmv_wnOWSqBdB_+j6=mNitQ@mail.gmail.com>
References: <80c59fb264f9f2c8b325bd792f0a20c172394e59.1793588058.git.alan.tseng.cs@gmail.com>
 <CAFLszTi20S-CDj+MrZR5LmfJ-0cvmv_wnOWSqBdB_+j6=mNitQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On Tue, 3 Nov 2026 at 08:49, Simon Glass <sjg@chromium.org> wrote:
> Just to check, how did you find this? The config X86 entry in
> arch/Kconfig has 'imply DM_RTC', and both qemu-x86_defconfig and
> qemu-x86_64_defconfig give me CONFIG_DM_RTC=y and CONFIG_VIRTIO_RTC=y,
> so the driver looks to be already enabled on QEMU x86. Please can you
> drop the sentence, unless there is a case I am missing.

You're right, there is no such case. I carried the claim over from the
v5 discussion and didn't check it against the defconfigs. Both give me
CONFIG_DM_RTC=y and CONFIG_VIRTIO_RTC=y as well.

I'll drop the sentence and the DM_RTC part of the commit message in v7.

Regards,
Hung-Chun
