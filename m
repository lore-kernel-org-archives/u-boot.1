Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E534606A323
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZqpAzTjs;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=caX6iH2A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED54C606C2;
	Thu, 29 Oct 2026 09:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGT1knjqiK7r; Thu, 29 Oct 2026 09:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4103F60686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793267865;
	b=HZNVztSrCXG8HM7wyEzozYCpObZpDin9E12Q9zQojomcmoGJMypocIFbZvqPLeS99s/t
	 0d0xsJ7u7LFRINiO/rdvFj8Fm+CD+kY+h494afHvNOtqC9sffuFxiEp0kHlAdMqPUrcj8
	 fHGMcCuLiK9oZDnXq0IajR+uG8wtLffpLR6zobjMZVx4BI57tFgFPWHo8iWxJ/81N5SsU
	 yLICvAP5BmmLcqKVggfFwkKkrzfwAQOGqxwAzAUN/60Qi5X5JEWtsFTCxb0pc0KcPtLZx
	 Ih/J7+cunlnBoSXIf1YiVnjLK93KG8tq+2Smn8GEnHxPIt7aomVjLds2nPK1o7Yi+SQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793267865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=heJAKlEXVKzr6vK8+ClcjlYgs1qWyTF/x1t/31HHcz0=;
	b=YN/n8OJurcQp/JIvR/XlwkqkfozoU18AwGFh4FF9E5L5rTkAJWNGjsvcBmTh3k2Hhznj
	 es1Mim+UHVTGPEc0rpYQArmYDs7WnojpcXzFjRMDJWVytEPBABARp4ZEFjC6Z5SYhLgpO
	 XFH75weq65QyY/KRkZK9C+byqNYzoIYmFsHgLl3zAUCR9clAnXdpaQeT4cfQrZNdjS7un
	 QpRkbOOJ2/C5jeXib7hn/lsBJJ0MGpTf61WE19QvuWgvbuauyLgEz70+Aw/9iDH52hEBF
	 MIJL1PNzjOB4O5Jij/LEjrISjsR1yj59iTGF9SwUVkfmMK0OtvArKl7VvcV0Du7XZjg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793267865;
	bh=heJAKlEXVKzr6vK8+ClcjlYgs1qWyTF/x1t/31HHcz0=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZqpAzTjs6g82UzeE7eEibX5b8PvecrWxRyNGe6KBD1oVOp6iiofitKMsEDZr/kS6G
	 Ye4NVu2OT8FUgVihamsH1aVrRXf9h8j760HYly1/lB0k6ttJPDpX8bTtN1G2U6S6EF
	 LMflnejoHpmcg+veLvkqXsZoamua7FByg4HmQp7qNhvyBMs/25ascIxQVjFV3pKQ4U
	 VWfjkKDCNWJdg7e/cQ8DWpaVSvVp79Gcl56+H/aYvQjjHJlU54py3NHIzXwPWCTrGK
	 FC/erQsB5np00ruDwpCI898G6qghjyaA2kq4HjaN7rK0okvxflMod2qx1J5H3rtImd
	 0+gXpQU+hM3TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4103F60686;
	Thu, 29 Oct 2026 09:57:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2D5A356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A91A24068C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjlUjti837R9 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A968440574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793267863;
 b=QeM6Vs8r8ECAL3txiy4EsnQT/NsHtHuGWfNTSFUY5E3Hkl8ZjIeVjIuE2DMysXV+MFDK
 9ZjdqaHBj6V36HmM3RNwOQre8HvSojj61pUDxdtvRR1v7gcmnbD24YTv1U6/N+1YX2yPU
 3koQN6taTJ0PZSRP/t5gpKE/lSutXGWAcX8iQKLHxtFS3ADwVB8pJ/UGwNPmtBfdZZ1NY
 5y3iqYmSEBXhyxF1dBj85l5Ketw4Ey6OiNd9r5P7+EmySSk1HOoh86/YaVDlQdoY+2lqX
 Qjyv0/KDDPY0CDl+mr9Lb5IDGIkC2RySEJ0Dka3T10JjTSIg7nF9md9GfY6F2dwqU1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793267863;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Content-Language:To:From:Subject:Content-Type:
 Content-Transfer-Encoding;
 bh=heJAKlEXVKzr6vK8+ClcjlYgs1qWyTF/x1t/31HHcz0=;
 b=WbzrkxKj4SYSamegjbsZl1OcbdkNWfcrzTZ65n6ar3UVhj9Dr/Lf102grO3ggnLqmPoS
 FH2TUBrGLSfmcXYL8wRk1dwUvgburqe5ZACImuXihdw1/2qmJm1cDx9fQ8vYrSPOW72u+
 jAXgEudLYxZUSBhZWb4dzx5WwZPNUFrSiOGHmN5ld0ASBCym9ra87cEAEPF13ZPqyYwR+
 BjUifsDorVS3yKhHTYIk0lytricWOUueRbI1qsEGM1gh3Jni/TGSJYIJ3DO8pfn60n4I9
 xo65YvGCwWVNJFuWhZgJ0l6izVB+O6wtiYJRrjW6/oXwKG1pOe7uQQhAe5wLBTWon9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=caX6iH2A; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=caX6iH2A
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A968440574
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:57:41 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1569545f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793267860; x=1793872660;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=heJAKlEXVKzr6vK8+ClcjlYgs1qWyTF/x1t/31HHcz0=;
 b=caX6iH2A27MGimS4Icui3QjttqbghdIS4us2lgrQzmUnUPhofVuOsofejv3CYgH/SB
 3hxSNt1tE8IFbI/SDEOxtK5OBq+NJv80mtKn86970bxnIN1cqasTHhvNnWrO2tqfxd08
 WpJ6HhYXQCwvUXTpeQLU+UDr8vn7LxXQhDnqoN1nV4aRT1JkTWOt2z9dBLYhhfRzZeO4
 0WqJSirbKULulLU+0F+vawCwXNxjuNKy35W9ELlWItLCVkdrjHzjQmuS2mZUOvImN9bw
 OHNfxVCxcgaMDMpcah0LFRhODyIo4bfAAXizt49bFSwBnq8SGdov8AcQ4s7/Ecr+oVzM
 7BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793267860; x=1793872660;
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=heJAKlEXVKzr6vK8+ClcjlYgs1qWyTF/x1t/31HHcz0=;
 b=nSKoEeOc6PkjYBgE4jDkjgCYNJ4fz1xaKKP4l7PGleZhAWAqKuh9Bu9dLNWILBooMY
 QvD/K9Bg9vgTrReFLVMxgk2zvOwoPfMOv6sDikMXr2eyJGUYKGN5CYnCK6qfD07TPGoZ
 AuJeNtmz0RqePy91qLQiMXWafgMJMdQsnEEjjpnUFpyVVhJViPyzlvgwmF+7FBfBKLV+
 dl9lhRo0DVzhznUezhH2ha0Yqc3lDU10Sdm+uPOx09rsE1zbmdhoRiR0nelygENBA5u3
 Dr/MWXdzatkJU/wayrx7wqoRMPLzEGRFVi8p6S5aKW9EOc8ZoajoNg8sfwAaOdrVhvri
 FWDw==
X-Gm-Message-State: AFq9FYJhWrHImgoH8MAHf2wCRU6vC/Y49tf0Wm5U4Z1BfAkoknRfG8TA
 p+1zZ8Kq9AmhLJtO4IuqGlKsv2YdTwHRNdQzDlXGF1ZRO3v1EEyqh5nbDVZashuHpkvfwX7tQFH
 VoVOE+FY=
X-Gm-Gg: AYBFou0YBVp4eNy/Q9v88Hk6rkauphwwBV/lRMPyXlhTR3KHYU2DiSKWvYFi1K50O7i
 hSJBs+ARxTJMKiCBu2i8EESnn1OVyabS7Ch+SLScaBbjmI98aSsjyKOdPIs3LyKx05KbfGQQVKE
 yNQ9Uf9pAhG4X9R0IgGgM5XGfHw98sVPfR3qG2pUCu4fVK/0+rBMmUvMUZxApBp92rFfPbHYwEO
 EpE2tJHPFtrhfTPaI7q4jNYNZ+w0/8VaQXF2u4lb365A3D4skQaD0mR17REaT9MqdlKuUsNWYI2
 hG0mNOV+YSuHBND6MIgz3Po4/zgQ53g8Uf7axjuM3U8Tc40IX+Zqn90B+4Q6vHZKBSo07L2H37P
 yoNXcwtE/wQSVdzdEZ1ORt0grjL2Ks1pKcz9hoAnNcp6PZHCk32tU6QXtKwwwUKGX8PyH5Vu/GD
 zztCMQN6Ihh6CGo0OyjuytkojObhlzVpTAy2xxrQO2IqX1QbdbXokkHadn7CxibSfVsAWoiabgy
 BF3JP+n/0TVU5u0QBFcmJ/4n/VjyMz+tD7zpqwe0IOi/2wWQd+OwAFLmlKXgLjDUN/4hO2Bg9Gu
 iRD98/wQ7pRsFpQzRT1L28bBZRaEeHTZmn/Z/jPoV+K7wN49fpqpzitgYlknPRzyi0Gyu4BRktM
 cKd2DTcZBbjdzGBNgQPm0s6D23mck
X-Received: by 2002:a05:6000:606:b0:48b:2a2:31dc with SMTP id
 ffacd0b85a97d-48e5d3126abmr11409174f8f.49.1793267859971; 
 Thu, 29 Oct 2026 02:57:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e16:1f01:42b2:5ded:c465:df1c?
 ([2a0a:ef40:e16:1f01:42b2:5ded:c465:df1c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm31638826f8f.7.2026.10.29.02.57.38
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 02:57:39 -0700 (PDT)
Message-ID: <9be46549-095b-45b5-a6fc-a527f1c7a0dc@linaro.org>
Date: Thu, 29 Oct 2026 09:57:38 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: u-boot@lists.u-boot-project.org
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: event_dump problem on recent OS.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am running Debian 13 with binutils 2.44 and have come across a problem 
with event_dump.py

With LTO enabled it fails like this:

$ ./scripts/event_dump.py ./build-sandbox_spl/u-boot
Event type            Id                              Source location
--------------------  ------------------------------ 
------------------------------
EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           :?
EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    :?
EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         :?
EVT_LAST_STAGE_INIT   efi_block_device_create         :?
EVT_LAST_STAGE_INIT   install_smbios_table            :?
EVT_MISC_INIT_F       sandbox_early_getopt_check 
build-sandbox_spl/../arch/sandbox/cpu/start.c:61
EVT_TEST              h_adder_simple                  :?

So it cannot find any of the static functions. Adding back the __used 
attribute does not seem to help.

With LTO disabled it works:

$ ./scripts/event_dump.py ./build-sandbox/u-boot
Event type            Id                              Source location
--------------------  ------------------------------ 
------------------------------
EVT_FT_FIXUP          bootmeth_vbe_ft_fixup 
build-sandbox/../boot/vbe_request.c:152
EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup 
build-sandbox/../boot/vbe_simple_os.c:53
EVT_LAST_STAGE_INIT   alloc_write_acpi_tables 
build-sandbox/../lib/acpi/acpi_table.c:806
EVT_LAST_STAGE_INIT   efi_block_device_create 
build-sandbox/../lib/efi_driver/efi_block_device.c:236
EVT_LAST_STAGE_INIT   install_smbios_table 
build-sandbox/../lib/efi_loader/efi_smbios.c:59
EVT_MISC_INIT_F       sandbox_early_getopt_check 
build-sandbox/../arch/sandbox/cpu/start.c:61
EVT_TEST              h_adder_simple 
build-sandbox/../test/common/event.c:34

Andrew
