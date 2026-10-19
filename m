Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AA7CCF2E4
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF5E060612;
	Mon, 19 Oct 2026 11:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NofZgvnd33HP; Mon, 19 Oct 2026 11:44:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B8FE605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792410256;
	b=dbc98Wzhf1Exx4hD764vFRUz6mATQ/lliMVGe5iQpSJT0gQ+ekbcfGYV1ofZvsCksZNa
	 2NSrX2Emk8STk615/jqEO9Socm1+rUUUaacutuODgPw7wjQ4juasLgHSySSp9QsEYx8Wp
	 wPlpmK49kML7id0X2DfL6y3tWPQSl3w7IiQFnwHlrYjHl3VfexqoVAYyvO4qR5KYPaLfU
	 e7EGWWwa4y2na+6vZLWJEsMOkps7C6QOKCZZ2a3CrMdZUiQ/BvYOxQwNBx3Gmjdw9guNf
	 bL0D4hSCS6lFgC/c0HYmLjZ0p36ZlbdJiK5NQe+0BGDK2joxR8rnHXXrQzzg/k7fGfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792410256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tQ1FJHMUUaNw43AOOaYoZ/lwUEga2XXabl9XSKJmLLc=;
	b=O6tmB+GqMKxIzzE602A2/5ymczHFZ3MOPg1T0/u31b158rZ9301NJVP5IRWi8Dn+fRBn
	 wxNv1+4kNH8vztXUHwWiBQ6ht/oN7c3puGJFRdJH80Z+Q2NC5asOaGZdDouHivDqnMUa8
	 Ofj67vSEkNqDYdDFCpT/Ct1xjDkiFTHSvSXvIjBSR+a+h8kAieyxwsKVnWWJuHphTh0Va
	 ysF1m1dhoIHklIyKi8v4S96bRDSInfLme8WJg1fahjV8EhDo/E2PGJ3Rc5RJQuMti3mDp
	 8FxU99bgWygwBn3M+Ya0BEqAX9FoNEz4REbBQyCnFXbk56f0UjwGyn8Hz3/p5HpMwQQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGFjYi0y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792410256;
	bh=tQ1FJHMUUaNw43AOOaYoZ/lwUEga2XXabl9XSKJmLLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xyItsi4TCS9MVhABDYolxIBs1jJ53tAHk4z9b8StCAFNq0LFegSHLrVspykD2HCPs
	 dtnCgP8XbOjl4HUWSUIe3l/ju3tzdVXanq8vtoVs23NdZm6J64x/frlBe3UJBYNuKx
	 ZSsqbYzD1Di/jhgnT7kKOKy9kXPLVkNwQMGWM38fUh6/47KbGD0QcnHnYRt5U8sN+U
	 t/s9v7yHD5RLy/0BVu4CbGahjxie/QOJOHKn7Z3dMSrxBA8kb4IAT+6EC1983ZJaFm
	 ZbhRTTp9dU26D81zx4IlO5Ivg4+RnsWNcNMnErzDMnq9bn8HWDAdzEN0eAtqOsOm2x
	 +1jWIrxfAS1tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B8FE605FC;
	Mon, 19 Oct 2026 11:44:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 28EE3263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A8DD60600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMG9IvhtegVn for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3EC8605FC
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792410253;
 b=nkgCaHuXyvLPeipdduWuhOEkqJlfwIZFPLouoUKRfuI0LzZf6S3QA/ZxMIP3dQUgKMRH
 Y1FCFrANx8/OWTvaWY/QSWiVyZHKLNc4aOKsq5gbkvflJhrMGkUKaMJtRCXSyLhJ7a/AV
 M99WMaLByZAQF7LkcaKO7oZ2TacKOVSUNyRQmQKZVuBLr+3UZdBFsjtPQ6Q0+oFOSbDbv
 mSshZgR9+GhtXXWlEVeKwyJnBA4W4kSLCnhr/YkowgD9CjizHFfSTGPv0+tUWrGgJmMzz
 pA4WT+YJhJsKXgOp9VNWE8GBSqA0PxvJmBEO9KDNxzzMd47iecYbrV8m42fj8fn5gfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792410253;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=tQ1FJHMUUaNw43AOOaYoZ/lwUEga2XXabl9XSKJmLLc=;
 b=l1mm4FwHyzV70Vt6T8ZsBtAqzSnO05c820yOXfdosQEL7RBdMeCPEJXTnn3UFXHjz8A8
 JMRhnBwixx+HljqEubQ+ExT5VbCCDtFzYF/Bw3UPp/OjFDzkMlFXTciCGz6yZcWTOHzDS
 yFM43GqcQg5b78NmVc/yQGlra5Nm20L7p2T/vbp+MRojGbRf8d+2eCQbRS0NNP8OA4nze
 VuIQriLOeE961gHLKyhObg0SHCaSuJ6LaxcXbb8rNlJxactwxqOjC4yyOa/SQZJ3z0bJ9
 KN9kQN79XutMXIeYfqe0i6ewdBOhVpW6ApnqWKv5s/7VWxG+8T1NmUpspXwQ9UkPREg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dGFjYi0y; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dGFjYi0y
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3EC8605FC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:44:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40D7C6022F;
 Mon, 19 Oct 2026 11:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4688F1F000CB;
 Mon, 19 Oct 2026 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792410248;
 bh=tQ1FJHMUUaNw43AOOaYoZ/lwUEga2XXabl9XSKJmLLc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dGFjYi0ySfVFGhC0aQuo0XYi1jPtPOZSZsyHVVXnRjXsYXbDXVT5KIVmfYm3Fodc9
 41dnCyydElDf+x5wqEht7sCLz04jzbeD6ObbuaIUXFXSSgpOO5fjL6nQ0BZDyIVWgS
 r3b8ZnGhZGSWdeNAa18RKN7NKbzC6zDV48DobcBT1aHRgRzC6qfVLSudCD3xUpz4cz
 JBkBfpUG6hgEjt2Js2LhD5OFhxLdkxsaDPyWSOuhhDd1nSbcaaPrXEtP6kla72P1Lc
 nEy4LBxRTytkmp4lBZz+KCrje3OS+ip0YV/hT+blDkXS6+5X47Jp8CZi9FiNr8R6gH
 DCqp7GtpRkuCg==
Date: Mon, 19 Oct 2026 17:13:59 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: Re: [PATCH RESEND v5 0/5] Add FIT multi-DTB selection for Qualcomm
Message-ID: <atYCf3hDVgplILo5@sumit-xelite>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
 <20261012175042.GD3722450@bill-the-cat>
 <6bff4593-8182-4524-be00-6963ed9330d4@oss.qualcomm.com>
 <20261013150307.GB4042005@bill-the-cat>
 <atIVfAF9YZ_Ocp7S@sumit-xelite>
 <20261016162742.GK259661@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261016162742.GK259661@bill-the-cat>
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

On Fri, 16 Oct 2026 at 10:27:42 -0600, Tom Rini wrote:
>On Fri, Oct 16, 2026 at 05:45:56PM +0530, Sumit Garg wrote:
>> Hi Tom,
>>
>> On Tue, 13 Oct 2026 at 09:03:07 -0600, Tom Rini wrote:
>> > On Tue, Oct 13, 2026 at 12:50:42PM +0530, Aswin Murugan wrote:
>> > >
>> > > On 10/12/2026 11:20 PM, Tom Rini wrote:
>> > > Hi Tom,
>> > > > On Mon, Oct 12, 2026 at 10:37:49PM +0530, Aswin Murugan wrote:
>> > > > > This series adds dynamic device tree selection from FIT images for
>> > > > > Qualcomm Snapdragon platforms, enabling U-Boot to select the
>> > > > > appropriate DTB based on hardware parameters detected at boot.
>> > > > >
>> > > > > Qualcomm FIT-based DTB format is documented in [1].
>> > > > >
>> > > > > The FIT image contains only DTBs, while the kernel is provided
>> > > > > separately as part of a UKI image.
>> > > > >
>> > > > > The implementation consists of:
>> > > > >
>> > > > > 1. Hardware detection infrastructure: Introduces the qcom,hwinfo
>> > > > >     driver and qcom_hwdetect helper to collect hardware identification
>> > > > >     data from SMEM, IMEM and TCSR into a single qcom_hw_params
>> > > > >     structure for consumers such as FIT multi-DTB selection.
>> > > > >
>> > > > > 2. FIT multi-DTB selection: Implements DTB selection based on the
>> > > > >     aggregated hardware information. The code parses metadata DTBs,
>> > > > >     matches FIT configurations against detected hardware attributes,
>> > > > >     applies overlays, and loads the selected DTB for EFI boot.
>> > > > >
>> > > > > [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
>> > > > >      Documentation.md
>> > > > >
>> > > > > ---
>> > > > >
>> > > > > Changes in v4:
>> > > > ... which was sent as v5, and this is a re-send of?
>> > > Yes, this is a resend of v4, which was sent as v5
>> > > > > 1. Drop the SMEM cache infrastructure.
>> > > > >
>> > > > > 2. misc: qcom: add qcom,hwinfo driver to provide a common interface
>> > > > >     for reading IMEM boot cookie and TCSR SOC version information.
>> > > > >
>> > > > > 3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
>> > > > >     information from SMEM, IMEM and TCSR into a single
>> > > > >     struct qcom_hw_params.
>> > > > >
>> > > > > 4. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
>> > > > >     of accessing SMEM, IMEM and TCSR data directly.
>> > > > >
>> > > > > 5. Separate hardware discovery from FIT parsing and DTB matching
>> > > > >     logic, reducing complexity and improving code organization.
>> > > > >
>> > > > > 6. Load FIT images directly from a raw GPT partition and remove the
>> > > > >     FAT filesystem image based loading approach.
>> > > > >
>> > > > > 7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
>> > > > >     related documentation updates.
>> > > > >
>> > > > > 8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
>> > > > >     qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes and
>> > > > >     board-specific offsets.
>> > > > >
>> > > > > Link to v3:
>> > > > > https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com/
>> > > > The FAT comments in v3 were addressed. I'm not really sure the discussion about if
>> > > > this approach makes sense as really was addressed however?
>> > >
>> > > Yes, the FAT-related comments from v3 were addressed in this
>> > > revision by dropping the FAT filesystem image-based loading
>> > > approach and loading FIT image directly from a raw GPT
>> > > partition.
>> >
>> > Right, thanks.
>> >
>> > > Regarding the broader design, the reasoning for using a
>> > > DTB-only FIT was discussed in the v3 thread [1]. The intention
>> > > is to support firmware-side DT selection while keeping DTB
>> > > management independent of kernel packaging, matching existing
>> > > Qualcomm deployment models. This is intended to coexist with,
>> > > rather than replace, approaches such as UKI DT bundling.
>> > >
>> > > [1]: https://lore.kernel.org/u-boot/afSXa7q7hJC_ZW07@sumit-xelite/
>> >
>> > Yes, and I'd appreciate some of the people that were discussing things
>> > in that thread chiming in and saying they're happy enough, as it wasn't
>> > clear to me in re-reading the thread yesterday that the discussion ended
>> > with agreement and instead just stopped.
>> >
>>
>> As of now the Qualcomm subsystem maintenence is in really inactive state
>> as you can see from the list of patchsets even carrying review tags are
>> missing custodian attention here [1]. If you remember it from our earlier
>> private thread with Casey and Neil many months ago, the maintainence
>> situation hasn't improved at all.
>>
>> Even as a reviewer for the Qcom subsystem, I have tried earlier with all
>> the reviews but patches were still floating on the list, which just
>> demotivated me from doing further reviews.
>>
>> I would really like to get this maintainence situation fixed. Would it
>> be fine with you to accept me as a Qcom subsystem custodian with more
>> people from Qualcomm contributing as reviewers?
>>
>> In the meantime why we decide on that, can you help with picking patches
>> which have been reviewed directly for the Qualcomm subsystem?
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/list/?delegate=151538&param=4&page=1
>
>I don't have a problem with (and a number of our SoCs do this now) have
>co-custodians, so I've reached out to Casey.

Thanks, I will send a maintainer entry update soon.

>
>Since you brought it up in this thread, you were in the original v3 with
>questions / concerns about the approach that I wasn't sure if were
>resolved.
>

Conceptually the concerns are addressed, I will do the further code
review shortly.

-Sumit
