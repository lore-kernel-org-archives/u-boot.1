Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D880CCCF9F8
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 03:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA41982A9E;
	Tue,  4 Nov 2025 04:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afGH5r2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 843748389A; Tue,  4 Nov 2025 04:13:32 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259D68144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 04:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-81efcad9c90so60109276d6.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 19:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762226009; x=1762830809; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YZR6yxIudcjbnLKJAKPPP2PMx2gzReCvfc16G6sU0DU=;
 b=afGH5r2JdNGkoS8mknqLtNW9BkNAR+KpUEkWnAT8mwVNKkbeTML0792rjKOLxIr4eW
 0u4qchQrUCAqzb9xC541u6Z8WfsAi+smC8t9omDAOhGdbqvVqth2SuceoAVrf+Sv7g1q
 Z7dxuqQh11I3XbuEUVbPS7M7vrK4HqL4SNxBVWM+40d+DKvkqEUYz4XwqzonEzIr6kpT
 4HZ53zlEGme5X5yQDIDq5lPHaSFQXPLHFGw0Iz7121e31mVaiMdJVAMRQ6mm5+wiouQl
 4EKkY01Q7CUswOuHo1zmRqGjn24tDLMIbf8M9vKHHSZ/3xpYWZs+yYMF7xoblwpNqzQD
 xy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762226009; x=1762830809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YZR6yxIudcjbnLKJAKPPP2PMx2gzReCvfc16G6sU0DU=;
 b=NxALcDm++nMBhi+krh+q5nPVG0T9ddYWUuBrQbGc1odpPmHSQl6VAJYanXwxRKmFoA
 UvOXaVEW6rTJxiU5TY75hX8PF3fC1xwPdfmc6AS/ObxB355Oj/ICOtsX6SbiEwrkQQRd
 OjiLNPR82GBIt1MkiZDsBURAGcKSj5HESeTaXT+M+iMC/j9YgzNlTdKunhXBIVX4hldQ
 4nweKeMYUZNJg/Y3Cjwk526bpfZ71vanMAbrpc7q2Goy/+e0p5HZAbx3N9LIjF2ixoyd
 iSC7ICt+YQ8hYJ50lwWuUUYyilTmM4WVQzNZDj5jtw8/MiU5Vxd6LQnBBKwZcboMaCHx
 sYyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9J+5uIQO/riKcrmkRn7QNz7swBhiTIu8+totJVwfpIIoXQLxsWUpJSMZlRaffHDmJoansEzk=@lists.denx.de
X-Gm-Message-State: AOJu0YyL1plFoue19XLVbmPdQYRh7ugtgLpakVKULqh67c9ecpD9nZXv
 4dhp1WmkeffLTAmsFk4WKTyMjjBlwJOhyjmGAU8K31cASEq3WxKOD7Iz
X-Gm-Gg: ASbGncvraROye5J+zyahrjgU7Scl9auVmSROhtPc9OCSrSf9EvBNKeXfvTYNqtCqNf5
 T3zxOS2Ih4979O9WZ9HhYjPyPo3LDTKJTNQzPTjVkeldWncJnCTlmnHek8INlcAZ//f4QK0WZkp
 K8eFIKJSeO9A7VKnULNGf+2c7Y2wVBbsBtMofv7LAWZlA2UChW8NN8l7c9gPw3WyM5RVO4O5ydr
 SooaMG0qxMGRG4o1V9aPRF/9ls4r+nvfTM8SW/Pa2p4pDTBtihkWNDJJNOpz5zqKYbVNtNFCl5c
 AiZrdTjTKCx3OdZr6NiXpJVxz/oMJgLN6fJiiAfQJ/ug0wOugrhVWAmsdyeqUOL1Nm5LcEbb5dg
 Cijjtek8pQEZd1Fn0XMAENHd/SgjBXFX4DvDFMrtJd0oEkL0I32S4+1wLhbvw4b32dwIyNa1NDI
 kGwHMk1QbcUXmIwTqksVzcGag6nSeLQtwqHkA8zMg=
X-Google-Smtp-Source: AGHT+IGDDZsYnnlkKyfYd3y21lt29GUL/GLz6A71yKFeyhBrTOgLb1mwlgZgf30mQy2kfUBUa0BqkA==
X-Received: by 2002:ad4:5d67:0:b0:7d4:e416:ac05 with SMTP id
 6a1803df08f44-8802ec30da7mr192889646d6.0.1762226008803; 
 Mon, 03 Nov 2025 19:13:28 -0800 (PST)
Received: from [192.168.68.100] ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88060db6137sm13037386d6.4.2025.11.03.19.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 19:13:28 -0800 (PST)
Message-ID: <745a1137-08ad-4365-9712-35a45b9ed6fd@gmail.com>
Date: Mon, 3 Nov 2025 22:13:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5 0/5] Enable Firmware Handoff CI test on
 qemu_arm64
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, raymondmaoca@gmail.com
References: <20251021181703.598342-1-raymond.mao@linaro.org>
Content-Language: en-CA
From: Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <20251021181703.598342-1-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

Is this series ready to merge or any improvements are needed?

Raymond

On 2025-10-21 2:16 p.m., Raymond Mao wrote:
> This patch series enable Firmware Handoff [1] CI tests on qemu_arm64 by:
> 1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
> 2. build bl1 and fip with both Firmware Handoff and Measured Boot
>     enabled;
> 3. pytest to validate the Firmware Handoff feature via bloblist by
>     checking the existence of expected FDT nodes and TPM events generated
>     and handed over from TF-A/OP-TEE.
>
> Pre-requisite u-boot-test-hooks patches [2] are required.
> A test pipeline is triggered at [3] with hacking docker image [4] and
> test hooks [5].
>
> [1] https://github.com/FirmwareHandoff/firmware_handoff
> [2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.mao@linaro.org/T/#t
> [3] https://github.com/u-boot/u-boot/pull/818
> [4] https://hub.docker.com/repository/docker/raymondmao20200915/uboot-ci/tags/latest/sha256-bff18c1f2488d350e9e6e51c9987e24c36b3bfe110079aa0682964c815dd285a
> [5] https://github.com/raymo200915/u-boot-test-hooks/tree/eventlog_handoff_v2
>
> Raymond Mao (5):
>    docker: add OP-TEE and TF-A build for testing Firmware Handoff
>    pytest: add test script to validate Firmware Handoff
>    configs: select CMD_BLOBLIST for Firmware Handoff testing
>    ci: check existence of bl1 and fip in the test script
>    ci: add test entries for qemu_arm64_tfa_fw_handoff
>
>   .azure-pipelines.yml                   |  18 ++++-
>   .gitlab-ci.yml                         |  21 ++++-
>   configs/qemu_arm64_defconfig           |   1 +
>   doc/develop/pytest/test_fw_handoff.rst |   8 ++
>   test/py/tests/test_fw_handoff.py       | 108 +++++++++++++++++++++++++
>   tools/docker/Dockerfile                |  40 ++++++++-
>   6 files changed, 189 insertions(+), 7 deletions(-)
>   create mode 100644 doc/develop/pytest/test_fw_handoff.rst
>   create mode 100644 test/py/tests/test_fw_handoff.py
>
