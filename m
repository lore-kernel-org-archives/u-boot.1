Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F20C5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 14:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0993540712;
	Sat, 15 Aug 2026 14:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C2PRldiXrbsZ; Sat, 15 Aug 2026 14:09:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CDE140756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786802957;
	bh=wwCxpiYT66y89Gjwr5Lg2pzOVl6/+ySHNXmohmKBdUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hMVfgF8ztzg7cReSi3D39FIRa7i13/c6TUYDro7hMRdh3dK6OmcG8bK0y3hoYWbWJ
	 zIfZNVAwlWipnmz/DsbdpSVpn8lFovwItJioQKwxKPqotlYGcFuYagMUZ1+Mk+ftyR
	 aAM6UWRL/DvXJzPG+ePdGMJUVvS9CpHCD/CYqjhSmPZA4sXCQ9TCL/qBllkffxDWMy
	 XFrtL2rjG8jYdz34pkpo/3ck9FUETv/iC3aY8CwkByhPt/MiKdPnXRihAkD54QBvPS
	 NyypyRXifaCZbsbDK3Qn1u01xvOcQjyaon6Jq1pXVjUj+PJMtVcCGLcXrl4pwS2e96
	 TMhRzFN/C7uKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CDE140756;
	Sat, 15 Aug 2026 14:09:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BC4B2BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61BDE40756
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w7VlueJ7IcLp for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 14:09:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 53B9640712
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53B9640712
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=i97beO+l
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53B9640712
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:09:14 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-930f72317a6so100921485a.3
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786802953; x=1787407753;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wwCxpiYT66y89Gjwr5Lg2pzOVl6/+ySHNXmohmKBdUw=;
 b=i97beO+l2zLXDGCsTz5y60Hrqt5qvG/zEzSVtnx3430schklkOvdnm00cleXmKsi+J
 0EcIpRyJ1e1z9RtT/j0Ylx8ArlKrh70eHDcalOjZynKT1vTws+kNBDkO59aKH5LkADnF
 7BG1+q8RajlHHrgDcBQue9Wk9qjRiriklYiF2MkPIEBEY3yPcCDVfw4ANg3wz7r9vemZ
 tuCxxXA6oNH1cLs3jNdVE6UgIifOsiKnfX4HyLAzhUyoR1ng8Um1hocA+dYodJi9qT+J
 NjanrAPKxwaanfxrICBzrqZ/0fJ0BmcxSbLLPLU2a59aArC4SEvTEcplXkDk2ZuxQzDR
 g5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786802953; x=1787407753;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wwCxpiYT66y89Gjwr5Lg2pzOVl6/+ySHNXmohmKBdUw=;
 b=RlTjZ0NsiCfs86/W+qwqdaep7SdT2191uO81JM5BSxnZTl1jM/Y8tufj3FvI5RZTUk
 jAjrFpk/QCC0h+7EIhiukRJTzaTOl6YnWR4lONmZjjjS5Ko+zPFTFQU/56JbLIviFcF6
 SBoFfNeNo6YncaEDUDbNkDO1aAKG0eDBBPYhoo222qAMIfssYdQIXyqYqXpaU5734OjB
 kLBgLMGYxdPg9uiGvQfL69I4Cx+2Z28cqchbf14KawfqfI9hVvY2bJ2HMv7U0yusE/Il
 N56SPnBc4PwvywLttF1kC6hGiWggf33gSxeq3frwVE6+90DMdw0MnPLgJ5GIognIE2rG
 F1Ng==
X-Gm-Message-State: AOJu0YxdwM/fPaj0u7oyMokwFTAvqN1yXX8tDrptN01GfO/NoaAYKP+j
 /Ge7G4trxOax1xm2f03BsjAn3vj0Ki09/KdqqW9kRZUrJsu8Mt3yHi17goVRYYStpWU=
X-Gm-Gg: AR+sD12jTfjvxXAUBiHI3La6ekIdBDnCMTaJLRS+hpKxN3XXicw4pvyWg6zy3ldl2hi
 sLUr29TKF/MqsPKfJtLatWUl1OAI49dL69KFTUtzfdjMYK01bYzTsFAWULwAg1ZONrjfWoJSB6s
 8eRVYr5GzLGklwlkL5D8Yn5OLVqlisVJ8AU+2wZ+xlCvQiqjZOGzQGdWNN1H7IntzVTIClgkvfm
 HixeYo32YpBfglyeQ5XtMKIk11c/fcx4m6KO3USTFG7v0X86OY/pz634l/oVDoWcXLgtTBuNlvV
 smu3W27KBmwFBpv0wr0qcT58apDEGxStpdOUpEP+0NmPu/F/Tc6rpiT51YLe7tPM9uQs5NGbU4K
 fr8kcioh6uWhT3/s5akNdA9f9frp7RUG4SHdj/UBFixsv2qMxjAaCxSuw+9WWJmDj6qUs0pWP2G
 nR8LoN/yadcu8eIJFA7vsnRW8Kmpt6ksxS1LrvwqzzqiNbq7AwKCE3zYb91USepF1MFO5FSK3U/
 +YDQVCl1zn/yjSQ3A8oVD7NxynuyvHr9iDC4gKWzIk=
X-Received: by 2002:a05:620a:718b:b0:930:f4dc:e7df with SMTP id
 af79cd13be357-936d233fd5emr1386515785a.24.1786802952860; 
 Sat, 15 Aug 2026 07:09:12 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce217c0esm554185785a.32.2026.08.15.07.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 07:09:12 -0700 (PDT)
Date: Sat, 15 Aug 2026 10:09:11 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2 1/3] spi: cadence_qspi: enable all clocks
Message-ID: <aoBzB2o_KUD6NwrC@maple.netwinder.org>
References: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
 <20260814-rzn1-2026-10-spi-v2-1-973d5fa092f2@linaro.org>
 <43fec897-24f2-40f6-b1d4-63a7a171a013@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <43fec897-24f2-40f6-b1d4-63a7a171a013@mailbox.org>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 15, 2026 at 12:03:55AM +0200, Marek Vasut wrote:
>On 8/14/26 8:28 PM, Ralph Siemsen wrote:
>
>[...]
>
>>@@ -250,7 +250,11 @@ static int cadence_spi_probe(struct udevice *bus)
>>  			return ret;
>>  #endif
>>  		} else {
>>-			priv->ref_clk_hz = clk_get_rate(&clk);
>>+			ret = clk_enable_bulk(&clks);
>
>Some sort of clk_disable_bulk() seems to be missing.
>
>Fail path which disables the clock seems to be missing too in this function.

Ack for both.

>>+			if (ret)
>>+				dev_warn(bus, "failed clk_enable_bulk\n");
>>+
>>+			priv->ref_clk_hz = clk_get_rate(&clks.clks[0]);
>
>Can the refclock be second or later (not first) clock in the list of 
>multiple clock in DT ? If yes, then the clk_get_rate[0] will return 
>bogus rate for another clock.

The right solution is to get the clock by name. But once again we have a 
pile of existing boards which may not have the correct name ("ref") in 
their device tree. So I went with the simple option of continuing to 
assume that the first clock is the refclock.

Ralph
