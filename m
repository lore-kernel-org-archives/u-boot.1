Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8878CCA490
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3BE381492;
	Fri, 16 Oct 2026 09:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q30_IG1aQKQr; Fri, 16 Oct 2026 09:06:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5B278148C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792141598;
	b=kkNkAHT3VwBwIxa2a8PBwWia/RGnUx0BiAc+gv/XPpuz6oZkn8xWZNDX2NDeGKcJxk+J
	 /gCEmD4/VYC84/uqyev1CP5Yc40BTnpa4PFp2FXFmJDjLNJDycJ6TqL6hW274O39L+Jhq
	 vEQMCx8dfiIXbU1lQUyfckCoKBPnXgsA39pYwehRzVjLiQvsZkuyeKiKNxxOWkRKOSrAa
	 X3r7mVuCoIDx92coZvIcL/bfcg+gtDMY66CjaaOSAbM4PmD4Qm6QtOyY6K/SpnwRPsTwx
	 oh/Txnrd6sZ7uyymP1K5fUl8qEGkV0D1Z9FFfeCkrcr4X2Ww0Jz4mztY+ZW7hK6qDPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792141598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QJzYXzUnbfUQFd5eRmWMFJXzUqae5dw7PK9XsyKNe6Q=;
	b=R2EkdRctGSDU8RTNeGVvyUJ2LDf3Qe0Q8we3/+JI1zIuMSH9dC0y6QArhZ7GeYfFkiC4
	 ryH6pbAW5S73RuZqJNqEJCnzkqv5C6bL7mE2JoSSGBh1pwiSnHYJCWLPzD13rYUqSUdlI
	 0CVWBw5R1gJzhV5HzLlA99V8LBuSoKEyVQJ82Av9WA96BVErdgORk06pJKEmx5AM9Mt8A
	 93J2FNVMh98JxleOqhyzKSvWXUKRRAnAzVERlMwhrwXVTLpa0a9dh+jf1Tgo1KyM0Z+sm
	 7M+BoE5ryTribEkz49p96oI3jhghaqjh4/E+mNLYKbGEycbprHjolPaAkHOxkCkStlA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792141598;
	bh=QJzYXzUnbfUQFd5eRmWMFJXzUqae5dw7PK9XsyKNe6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d2XM7HoRcyPenVEPL/tXRm0a6OKRb80QhqPKnXleILU88b+1xu1JsH6XxD5nE0srv
	 HNwoYkMxVC7te9oUMP1Z3xYXd98y3I/4qGEfpZKgMoUNTFYc+Rgsduw2DlKe0OF1L3
	 fz+bx/GhsGgejBLEfbSVFgH4bCt4lexNWUi0yhX3N/AI+ZhsqoKrRRW0GqvqhNCq5W
	 yV4buqNL7MAWFLWD3NvZL/HzxxN8sUrsU4acqohTF02ASwQwwY3nR1PFMYeCD5TVst
	 ZumgZVCyDZIpuHtpZlzv00lIUXlZxYMmMMh+NhVVbgvadfhLoeD4sIox8IjWBT4Woy
	 828+/XOaK11Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5B278148C;
	Fri, 16 Oct 2026 09:06:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 849BC362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8182960A9A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8RedABou3KU for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59A1E60A8F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792141590;
 b=N/RpmtudHkDJRpD9XYG4mtlU6UqOEKDckyAwNM4WN8tr+x9Del8VypTWQxdxqCnHDIVC
 4lHewRpX2ygquV90zCm0u8g26cIVZYfURNClVNqCv5nccvhhLmszOIxY9hbv4wxZrwKp2
 fGu5Mq7FSFRnFfcTVCPyibxrnjIGcoV/RAc8nt0h+LtkZXbWQTDqdChjVMHmzR0HBt8Ne
 aPfJ+PQoi0nUZKGQsubrnPbLYfuIWZS7EaFhpWiZxMu4Wd1a0gOdt8vtqcPa9I3hwy2OT
 7QddHIp5uEfEWfH6yreJ1Fe9xLXldCiFz7Nf72VAyCphwXGDbznbO1IHxZjKvG12OgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792141590;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=QJzYXzUnbfUQFd5eRmWMFJXzUqae5dw7PK9XsyKNe6Q=;
 b=q6CG1nGdVBj+4BhMGo9j3/ktCDcLp/tirx5PBvQw8PQM3S4Kss99RN2/yk8nYb6KPRzK
 7tmo9JuSLsZVZcGNZTF/q9ileAo8uvhz2DnydXoLCeE+7XXXoKWXO628Omjw1mCEzE7Rw
 yvSJI3pryfAjTlPN/6JNwOg8KNDFFGijDwB7gnJS+QCbQYuCAxaz00cDWj6AUIXO29BIA
 qq4W1vevrlCOpg3YD9XKsjtgz4eq4Vf66oir0/5dmbpeHVq4waVQ966kCOcAbFoMzf6ok
 rQ54vFU8chit9R34mq7tfAcOTLRUhlMj3YAbPzZz3okNGLmoPl7e6xhXmugV7HdaK9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RqDbIbgu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RqDbIbgu
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59A1E60A8F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:29 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49e73611928so4772905e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792141588; x=1792746388;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QJzYXzUnbfUQFd5eRmWMFJXzUqae5dw7PK9XsyKNe6Q=;
 b=RqDbIbguh6pRLzKPIUOsfZX6+IyRLPBTWzYWCbLYwvjWIaONbFwwSze1wiy05l/dkD
 HVXemYxEPTkby2Sk8lITvWRzLdLpUPQEfaAHggiMvT0prgOgEl318zyCtu/zc6+JP5GV
 oGm+s5fl0jtRI4G2+NLOTNw9qk1zwDuCUXeKk8In7i4U1oZyLnAYRmiWFYwHq21QgEwR
 tBYJ3dru7foPXMZ5ionhb7xzabyGY8bgIKeZjaBXEnFRrk+BL/DV3JuO9Gn8HC2wVuSY
 6XJWaqF2qE3nExDPH0GnWFwptdsozBqLVZpeK3Lezj68f3Un8rr69rCHzuxweuAJr5TF
 eLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141588; x=1792746388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QJzYXzUnbfUQFd5eRmWMFJXzUqae5dw7PK9XsyKNe6Q=;
 b=peYtW59tNGrwQAR/JnusJkMIs0dqSTDuJ6E//vKMFNc3rq02xeqen9rkmrQylsweT+
 cNiL6e1nDtL67QpE77Slx8awOI4yYRmi78eb9RIAbHPwbGjt4BMg1SRbH1+Ix2q6xxYY
 /cyXLVA5tUGiP3p0Z6v29RUU8wfZ6z4d8xQgh9FgzIgJR1MMOmiw9kd2GsR1mRyNc6xI
 aQhFjk3WOsYy59MfSfA0sIAsJxvayK/w5rvKaVY4bxYxXJGY6LWj5tQTkCefX+pqJ9dp
 MN1kp+LcVkw53dCsEZwr53+jNqcKyNU76+Btd5FIhxErxoVmFhrD5UxaPLxcDySu3O6T
 czHQ==
X-Gm-Message-State: AFq9FYIA91uwHrncp+fhKJEzEGrZ7hq0LOr3v06Fxc6/O58lzRhU7f5x
 oxjG2fWx/zh8zSGXj65xVk6Q9fHSTO2fKZOoE2VlGD2lf10INm9tRXQCkkea6INaNBcYVoROQbu
 WL1Cm
X-Gm-Gg: AYBFou2mJPsrntT+n+bgjEoGLCS1teYPj2mQFq7sNLs9ZW75CouwQLHz2ENTww9SRt3
 Bd8qfB7GRS+PkP+LiyaDKcLtbkWZTb1ASuBBJZpLE9nGyr/tlxfC+lP/V6Mlz4izo2Dkuh31Ilm
 AnD7lRLg6ys2p4h6l96m7BhpQSuYA3tilxjuXlHJ0B4DiCXsQxuD1JOFwEf+5QfGdKLbWYFCkch
 IzJLHWsA1T+ok2214arEess2vcawiMCWbdBDKFy3JIpxna0uQfJDsn5THtls+9V8UKForKxwxEi
 1JxKO+l0E1L8EzgYLJUPhhsyZCJHXz9EfB8pVa/3l6JTSG7fGZi+5n2jcCC4sm6FVeq7L/aKEVv
 VFgsQlRcjUxbyC5Zm/8B+cBQVX2FlEUyQwTeF8nj6Sug53lOt+lZC0NHmRFc9F0mcpT/OPn7mDZ
 99eb1iaLtCeV1pW+ThVoUHHQADZwBkOacukY+945gEV7mshD6C15Ls84SJ/eo/1r7x35yHMu198
 aOxjUkK5WbdyaGBC3VOrMORMw==
X-Received: by 2002:a05:600c:4504:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a1c6674ecamr58486495e9.11.1792141586901; 
 Fri, 16 Oct 2026 02:06:26 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm121287685e9.0.2026.10.16.02.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:06:26 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 16 Oct 2026 11:05:54 +0200
Subject: [PATCH v2 3/5] arm: mach-k3: am62a7: Wait for TIFS initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-3-c7ab53f79b34@baylibre.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
In-Reply-To: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; i=msp@baylibre.com;
 h=from:subject:message-id; bh=VdCm0FpN8HxSLse8xCIYgUz58wGxAH5FbjpzndfMow0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLLxnjF23oMc0u3yy6Jm35qZUF96cFnCs/kn9VTd6uy
 WMF83TxjoksDGJcDJZiiiydiaFp/+V3HktetGwzzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVB/wY/jvrDQr1OaiDaOsFmffXW27/NN7/XLLTymU/HHr+9uY8oqP4X/m2Vrt5Kd
 xqx7KfvoqVbRv4+p9bwt+cLBN7Xq8RGrbpUPsAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). Note that spl_early_init() needs to be done first to
setup DM.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 0d86d52ef267..da1ae57f2558 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -134,11 +134,12 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	spl_early_init();
 
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.

-- 
2.55.0

