Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094DBCFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 09:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 839D683F89;
	Tue, 25 Nov 2025 10:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iS5zZSeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1362683FB2; Tue, 25 Nov 2025 10:41:56 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944E883F88
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so41749295e9.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764063709; x=1764668509; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W3Q5qWvPrRVyizbtVJj6s/DyWH6cYaOB50eNAHPQHZ0=;
 b=iS5zZSeWPgBp/EwJbXPBRPM3p9FxGYOQ5NgKvi5Ye0EXDj5r3+zZ8jYkTigfyLzh1Z
 HaebgoTj0sy7jlG34Ki9KMvmqwLHatQFDTRG1q03rrdzzlU7DcjOmJJ2kj1j/jp0HH4e
 KJzWitFOiwjecfc42FT8YTjopauWpjLEfnu+6jw0BDGsJnNyAbgrvUL/j7xZ7JZbjs/q
 zPbxnheOBzqZchT48w1SRxb4AbQFeB1Q2Fd97JGm3tt2lSW1M/0ze0yYYjvymz/xmUp+
 fgCWIHnz8cWzDJ4GOCzZcsbpEWuLQc+n0CDJesBSQkX0qcI4UmIJIos2ylVY6deMdhCU
 33Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764063709; x=1764668509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W3Q5qWvPrRVyizbtVJj6s/DyWH6cYaOB50eNAHPQHZ0=;
 b=dDqz2kxCl17OQubeeJRBumyiURviXrCrkrTgWScswEvmT7f1Efuwoev27Bhxk6eOuu
 PjfS50gRuonSZusoQFDWgMvurdbCKIoAcuRqjqIGPuT8BXG9NLvHPzeqV8WhEMxzyKo9
 aFcIevY3ebkTFRIL0MxEFsVcqimCS5Dq9z0TZnsoa+19jUfavq3p87rozCKA5e/Z+BO/
 eOmkUqVXSJrA0OB1Q3LYSw+4NYCveC0UPBcJQkRnldJW4/h8OWZ3YWTCM+r4y1JUTgIj
 g2g1IULTDUaLNgLvOqNxf0bjzGKcTyqUhNWr7qMw3gbNs7BLzkXZgb/7s/U+h2UyB5Wd
 EdDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXudTYFV5JqGF58T31WRqonqSvUOMxiDY6DPl2wDM4fAYXItgUWB5Nj8eIkYnxaXM9qt/ifZ4E=@lists.denx.de
X-Gm-Message-State: AOJu0YzBrw/wM+2jlPy2kmp6AwrdStA95wKNVRcveUeczelIfTSCtyhp
 dBfLrUHNsQ/PXDat8qFEr7Hm6xTTHdONnGdHnlxRpxCU1eiALbA3QihNSS3WFe3kbgc=
X-Gm-Gg: ASbGnctjNMy68kp+ZZDFU5WNVV94jzMUvp50m8d5BZ9VRRU5e1uUWWomNKIxtooQSGc
 CfELUtC3Syd7YNoLtgIw9jAbbZnrDVzipGIhF7Ft0mD1PGm4sVMx73K9+dkakaCTxgyxkLGZhAQ
 74ZIuruC1katj1LZV9mVo3aIlBDa+vib42gB+HUfVSaOeoLFNJS6i8D9l508tr9ZMcVKPgWsPKA
 752obuLTylCQXtqslid6ALgj+4yxHDoDVPbFDLfnXcB+XoVVl+O63MitG+WkzgoSfX6ZvJay7zS
 JEXGoDCqSaX40rnVpXN0WRipGykds4Ier7S89S3cUHtWFslz7P40dbAbXkXvhqDOTW8SEGaWR2F
 ygx2K3VY0JI5X3e0IPq/zAJGMzQQnLxz6wyiFs83OJxDcY5Msl98s5wUPtKXslCNuaDKR9S2C4S
 X45R+cFpMi/6bdYRG34rL/FybMDb61g1jzAWsYMo3Jf9TlrrHKhJL9TJBnftdW32lJmRveK5hem
 Qgr
X-Google-Smtp-Source: AGHT+IFKCFtBNLXFwn8qIxGO1fqVJWolRYrI8ifCv1lSi7qi4mYs2j3nwlf+c51tuANHiM92X5HmCA==
X-Received: by 2002:a05:600c:45d1:b0:475:dae5:d972 with SMTP id
 5b1f17b1804b1-477c1123afcmr159701775e9.23.1764063708809; 
 Tue, 25 Nov 2025 01:41:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:98d:5340:478f:8306:881b:24c1?
 ([2a01:e0a:98d:5340:478f:8306:881b:24c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47906cb1f60sm9042625e9.1.2025.11.25.01.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 01:41:48 -0800 (PST)
Message-ID: <f5fa04f6-ddc2-415c-b887-adf3ba47a462@linaro.org>
Date: Tue, 25 Nov 2025 10:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] drivers: usb: dwc3: sync code with Linux v6.16-rc1
To: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>
References: <20251121153812.2076440-1-jerome.forissier@linaro.org>
 <f94e70c5-e211-46ee-9e4e-9a8f44c82cc6@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <f94e70c5-e211-46ee-9e4e-9a8f44c82cc6@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Marek,

On 11/23/25 21:39, Marek Vasut wrote:
> On 11/21/25 4:37 PM, Jerome Forissier wrote:
>> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven
>> years ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux
>> kernel to u-boot"). Since then, not many kernel changes have been ported
>> back into to U-Boot. This series is an attempt at synchronizing the code
>> with a somewhat current kernel (namely, v6.16.rc7 which was the latest
>> released when this effort was started).
>>
>> - The first three commits ("usb: dwc3: re-import from kernel v6.16-rc7",
>>    "usb: host: re-import xhci-ext-caps.h from kernel", usb: gadget:
>>    re-import epautoconf.c from kernel v6.16-rc7" and "usb: udc: re-import
>>    udc-core.c from kernel v6.16-rc7") replace files with their counterpart
>>    from the kernel, unmodified.
>> - The last commit ("usb: fix build after resync of DWC3 with kernel
>>    v6.16-rc7") makes the necessary changes to adapt to U-Boot and fix the
>>    build.
>>
>> Note that this is mostly compile-tested only. The CI pipeline on
>> source.denx.de was used as a OK/NOK indicator [0]. Only one config was
>> actually tested on real hardware: xilinx_zynqmp_kria_defconfig. With the
>> help of a custom build script [1] and with an additional patch [2], I
>> could boot the Kria KV260 board and make it detect a USB SSD plugged into
>> one of its USB 3.0 ports. It certainly doesn't mean all platforms using
>> the DWC3 driver are still OK, but at least there is some hope. If this
>> breaks your platform I'd like to know, and if you can send a fix it's
>> even better.
>>
>> I realize this is a big change and I did it this way essentially to get
>> going and be able to post this RFC. But I am not saying this is the way
>> the re-sync has to be done. Feedback is welcome.
> 
> Thank you for doing this.
> 
> Do you plan to sync this further to 6.18 ?

I suppose it would not be too hard. I can do it once we agree on the
method.

> 
> I will also ask the usual question -- would it be possible to cherry-pick this from old Linux until current state commit-by-commit ?

I don't think it's practical, see below.

> I can imagine the process would be:
> - Identify which Linux kernel commit was used as a starting point for the U-Boot DWC3 driver

u-boot (master)$ git log --oneline --no-merges drivers/usb/dwc3 | tail -1
85d5e7075f33 usb: dwc3: add dwc3 folder from linux kernel to u-boot

u-boot (master)$ git show --shortstat 85d5e7075f3
commit 85d5e7075f33e97079886027104591ff53d6363b
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Mon Feb 23 18:39:50 2015 +0530

	usb: dwc3: add dwc3 folder from linux kernel to u-boot

	Added dwc3 folder from linux kernel 3.19-rc1 (97bf6af1f9)
	to u-boot. This will be adapted to work with u-boot in the
	following patches.

	Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
	Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

 21 files changed, 9679 insertions(+)

> - Undo all changes from the U-Boot DWC3 driver applied since

OK, that one is relatively easy.

> - Cherry-pick new Linux kernel patches

linux (master)$ git describe
v6.18-rc7

linux (master)$ git log --oneline --no-merges v3.19-rc1..HEAD drivers/usb/dwc3 | wc -l
1347

That's a lot of commits. What exactly do we gain by doing this? Some
of the commits are not applicable to u-boot or need adaptations
(unsupported platforms, power management, debug/tracing, interrupts,
and probably other things I don't remember).

> - Check what might be missing

Essentially, many of the u-boot commits in:

u-boot (master)$ git log --oneline --no-merges 85d5e7075f3..HEAD drivers/usb/dwc3 | wc -l
216

I compared the linux and u-boot commit log and only 13 of these 216
commits have the exact same subject as a Linux commit after v3.19-rc1.
So that's probably 13 cherry-picks and 203 commits that are more or
less u-boot specific.

Also note that the DWC3 driver has dependencies on:

drivers/usb/host/xhci-ext-caps.h
drivers/usb/gadget/epautoconf.c
drivers/usb/gadget/udc/udc-core.c

...which also need to be synced so that's a few more commits to
cherry-pick actually.

All things being considered, I think it is better to minimize the
number of commits. Sync with linux then fix. We can probably squash
the first three commits in my series so that only one commit is broken
build-wise. This way there is little impact on bisectability.

In any case we also need more testing on real boards.

Thanks,
-- 
Jerome
