Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6C4CA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A40B60BA5;
	Thu,  1 Oct 2026 01:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DpuP-0rglKbo; Thu,  1 Oct 2026 01:20:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C07A60B74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817648;
	b=SMLUgsyHEHua/zoR4CzqY49UlVoFe5WZ0EIwWt5TWlN7Sa8Uc+dIXb3n8fKC8EQLDJ1T
	 uD6oqfFrFV9TPqH0xlNbSr3TChfREgLcCpz6qlpMpoIWxHrM1pkxIDv7TvUdAQVJrFki3
	 1gjSqAPZCMDREvvnqCf4A+KsOE8G291UWG4h2QT+zmbemuAWG96hrsonuBMWPS/OjUQH+
	 2O+qqx/eUA05Ul5xSaty/Wexqg8oP4YLgb84v18QtcQrcQFqh8r0wsP2dby1JOGB77pOz
	 VNX7U70wCn5Wpu6Vt+EVHOUeBc5tvJ4d2OhjmFh0BxvW0EAmkdJGQ4u24f4nsFSJIDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=83Z+LDyxeF13dAPdRhacD/932AiDNRp7rGeeunP+PZc=;
	b=HGRt7t4iLMnw2CH/UVK1yEEHthrrS0h9BvtYzKNOAzosvn8eA877E6GF9maaw9EXqbHA
	 XFWZEyR7Q/tQX0bV5faO3/gAmFh5OPrYfV+k+za7k+zjqCtVqXmCOrUuEihFkgzvW0nMC
	 JrFO7Y19m+2zzgElJT8+XU22WEXgYq6BEMdGhBjbXR/YS6+/5TGIqBEAMWFdrKlTNoPPG
	 FyrIFPb65WKmFoaj8mplflqMq1uV0UqY2g40B/FFMhMRmnWf16fwjeLm0njSC8XI7ySYA
	 ILx/NdqSvs8QJhUcdUS9NByS1VWUOhpgI78yK7pdi03JvDraqx39q7JaZw4uvRzgq4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817648;
	bh=83Z+LDyxeF13dAPdRhacD/932AiDNRp7rGeeunP+PZc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J1MeKaSzzwkzvJ9e/Lno+M1uCA0L5jT4mJ5ZD0JeRrIZldKYEsxtg3eAIP84tmdjX
	 IgJ4TKHflgzii6A5fujp1zZgklxI0Pk+vVR24Jht4IwQbYrTccEK3l8+09tq282osp
	 3n5d+GbW97DWBeGdarw3FQciWGRXkiV052PElNt4cN4Kn7weehbQVQIrBcJ9oDHPqS
	 EhP+c4TFBNVpU1zo+cHXH+Jfsqqpwosv703rtRot2GsHtJ0K/y/Ok72iXEh6KqrKrP
	 0T5hW052GBwUHOmnncKAlacyansp9OwVFU8UY+gn9QlTLEwUBb9oJKggsbH0hw4G5D
	 rouynCQ7Cn5QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C07A60B74;
	Thu,  1 Oct 2026 01:20:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8738A4C2
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78EEC40B24
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v446pF4ewckH for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ACCEC40B21
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790817646;
 b=S+c+tkFC3akKzMbHDwHjARdk7FzoDuVS0AAh/qIevbbDoSHh8Ys+uWLDJiDBDtaMKBdk
 uVsplMsxMSW+K0EBtoYCpW0apnrXvy9bQF+XZiMDDpkGRk/bmRoZ/Iycze9LERHSJhYgc
 Nuy2SZYGggPUuRlqOnMTYg1fc+cpZRCNSkqB6dzFqwLES195ZI4GMRiz2YNEh3gcMP1So
 aXKjdujlYQVfn5H3akTXy0kxs9sNVyfQPGAg53H1J6m3vR4l3cwIEdF7lsHRWBTrPW6Nl
 CQ/BNACKwjF60t5bmjme/tPmS58SFSu9pcToH1UVOhS9xVRiEqASbymBIHJH9CeiilQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817646;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=83Z+LDyxeF13dAPdRhacD/932AiDNRp7rGeeunP+PZc=;
 b=Qq0BhKG+JnEDxFgSifnoJm8lb3ESb7dsJl6Y5F4mN+UsVCbm9e29pe3E2iBR94sJy3Hj
 LpnGUmSWJJeCJ0QFXI1Ld+eDgw0zXFJp/zROjYdimGU+rCMSuBPy6avis6Vmny1rHI4of
 bTSVu4/slphyTRmCQoPd/EA+agw7f77a/4oz818kYctzuOOcobF23fB2VPlvSXP4PYJkv
 nvr8w3YK8qiFe4m2UoZCKxh8QescfDM8pI/8jciyNKHlecX7UpcIS49aTU51FVPbKLctd
 w3YHKVuxVYi3HcXGs0h/t8OfJQQ2OWoUAOB0Hca/jkNOenl+koPNleuG6L8zTqS0+ZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=REDGogvv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=REDGogvv
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACCEC40B21
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:46 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81f55c19dedso1347945a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790817645; x=1791422445;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=83Z+LDyxeF13dAPdRhacD/932AiDNRp7rGeeunP+PZc=;
 b=REDGogvvBmdB0OpIHj9qpa/zDGotWgOQGyf0r04E8Vu7IE/bxEn6YECBWAvLD9oP6c
 CeVF0wNVXlO0jEjmV4uh4mgKS06gPzbMY3SyOr+srie23bAzX6sVS7lQBG3N1HLOpd27
 gqai55ITHjpo9DAKEqdNUCOuJJkNJHQl1E5YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817645; x=1791422445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=83Z+LDyxeF13dAPdRhacD/932AiDNRp7rGeeunP+PZc=;
 b=mE/pQdSWuMiehiscaS2AjrwZoW+9SUUfWAQ/+vYgrSMARpzRImcl/lUm1rmZgiPPP7
 7IWgykxvdEWlr7Jrd0KXrJc/3UTMJHpzrrW0UrddGUdwsLYY7rc0bnTzJLc36hfjlYD2
 7x1FmnPFC3vsLU2Pxr+ARUIPBAVj0RAiCMiI+3k/FrriyF9D7Ud4fKBTQF4tkIpo0vSU
 7Ei4K0TtQP4QaPjxsIhbe+ZqA+feliavSsaBImMqM3Jlzd8MsWfZrcCikLobEyCyyGP5
 d5yV8ai9q6hzIkJc2ajJpirhnFJqXtXc9xP+DOQpHiG+BQW5Rn7UM7zWLfVnU59G3rwd
 nE6Q==
X-Gm-Message-State: AFuF++mSqYrB1nKA/Z83zrJD07hr38ypeOZA7XZVtTogOpQMpaUFhuEr
 gV62XfqTMRojlH6nvpdPU9RC5pHryovbWYfj9ptMGEUgqXsgfGS4wlbEaTYZoC4Ma8+9j8J43bO
 YbS5Y7z1FgyFY
X-Gm-Gg: AYBFou35H31kI4uXT70fX8aHn2eP4z3zo1UNlzcXVGBLVLE1F/C/9Jqcq+aF4xykdxx
 H5pJNgGmdhMWWvz5gRGT3l6YA0YSf6jx99B6jfnPVdjTgKx+Bz/DKIkvWzqBkB+CYmiQPjWJ3Wy
 awlE1EWAsWf7wb9h/WQ1WWhn1zSD36YioSeze2mdvKID+vmvwJSy/xRkyY8Z4Ygj4iVm/HcpQ26
 +PJYeOUUHqcjrtpj+qGeAdHz6zhTMRT3CB6Q96Q/whH1UV+1zrG1apWOL75XTUaRmhOquGGeffC
 f13Hdb6NfdSm+/zxG4n7t/k8lRtb2NI0Hg2LVQzQX5Kz5VESXKvvsWLf1TC/owiYkTuSW04auaq
 3vwS/dYyWmih5L7oGLBx3CqQRdk1MOvSAKJBpZReil4TQbR1gRmlrXWR848T6wHAsIqoK/pKHqY
 MsDRhIatfMwYSZ1JLtTwmOkYnrXOZHpUq4mJuD/sx+p+jF6cSXiRQr3ayiR99FCMOSd08tkm7+C
 GZh4CeRQazH5bpVDg6T6mmk9fmZ3WOXEJlVDJGYTlqFfkjmHBupY8GdAuHStRRvm4HTvLxxqTgP
 CPcUWaLFyp24MPlXZKkf1Swtg6mzWCiU3Tz3ZI4N59g=
X-Received: by 2002:a05:6820:98b:b0:6d7:5105:f6b4 with SMTP id
 006d021491bc7-6dcf5b2de0fmr3441297eaf.47.1790817645199; 
 Wed, 30 Sep 2026 18:20:45 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd9751a5a2sm1600586eaf.4.2026.09.30.18.20.44
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:20:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] Gitlab CI: Temporarily limit thread count on world builds
Date: Wed, 30 Sep 2026 19:20:43 -0600
Message-ID: <20261001012043.570450-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

At present, our "fast" runners provided by OSU OSL have a CPU thread
count limit of 28, which means that we don't run our jobs as quickly as
we might expect given the number of threads that nproc sees here. On the
OSU OSL side of things, they are aware and working on a set of overall
improvements to everyone using the shared infrastructure. For the
moment, we want to limit buildman to 28 threads when on an "osuosl"
tagged runner, and whatever nproc sees on the rest.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e08068f1cbf5..c5ff5341a1ef 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -157,8 +157,9 @@ build all platforms in a single job:
         -r board/qualcomm/requirements.txt
         setuptools
     - ret=0;
+      THREADS=`echo ${CI_RUNNER_TAGS} | grep -q osuosl && echo 28 || nproc`;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
+      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa -T ${THREADS} || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
-- 
2.43.0

