Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B19CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41B25608DC;
	Fri, 16 Oct 2026 12:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0DD9YJxi8su; Fri, 16 Oct 2026 12:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B46360877
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792152968;
	b=c/dxMPRgB035zzybYpr+9qEtBc8K39bm6bvT9AVHmcgDsI2aUhuslsNrkNGZgH2/JTDG
	 DvtuYR9BOzDRpd0N5YIpEdLCdi5yCvjY/t3q0Em7j5FZbtMKb9fhGx6/UoHSJFRZmJXmF
	 xt5GU7u0OVrYPJolaCVw4k2e9IZz8pDfS9fJt7XVTFh2zht06N3xlysgSBJ23oloGwO7d
	 ukrFNwQc/xl6SZAXPgSZD9VugT6kW0MRWNDndQ4KtXcOAIoJ85yCbGvBBvQ00rNrHvTwH
	 oRusilt9o7Ejd+EsQiuv/AdhU2i4zcdc8Q4paRYGKd4vD+SJxnBrQR52EJsjLMZ+uog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792152968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fW3YM83apiPkrnhDW20cNFxeHIIzzTEXZq1PadZYkc4=;
	b=gEbdd6iAjNvIi0BjB9u/nip7K6Y1M1OlWZr2PjEwsZyDIbgz0cwbGCUnQ86wY+iO6UCS
	 CoPwO4ZcUr0gYlB/ZY/8xNlLpXLXzmSF/I/aVAe/9sypgxdCbCZFzKyhJ5HtQrlFlQ+5k
	 wze1Asr4JyG/4fFRUk2xxbI6kD5iDvUHD96ube1y2mGbr0LIUxbpCIKjBMVhv9QL7ANU9
	 7Wxxk/EcQzuxOvdjIpjrd7AsudZgy6+5YvyGt0IjKGlYccXjsy5NfzuM5D3A32We73oHx
	 ddYqh61AYweMWPvSaCpYZlRXV8vYvd9+S5ZgOeyhOH6w8sDED5ndN1KDTOKfdGBXm4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrlYdLdb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792152968;
	bh=fW3YM83apiPkrnhDW20cNFxeHIIzzTEXZq1PadZYkc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mF6xlvdB1TUJ17CjkQ4Hl5X/NFq9Vy+SypXtGLUxBkA8emTluhd1Nnixc6oLqdMXa
	 ET82fGMWKuCsYf141MgIufdxppOt8uomJ5+JIGO3/48mm8+/J4iLo1gcQK+FuGxWAG
	 wAkAKdsUmF7D9JmqzATiffSw5Z0bNz6JOjmnXwnbMz5vNz/gosFbXqi0VMHU4cFs0/
	 FLknncYaWo/NgrWGUdQaz73dJv/dnc1SqspzRU18InkKaiiPqo4bTYFd6JDAlS7Vhj
	 /T30s09kxofvZcFqB7jAIcBaQt2Dko1K+5Zk354C9NH8X9StWLkg2DwyC6RCicBI2r
	 lRW34FkYjdZjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B46360877;
	Fri, 16 Oct 2026 12:16:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AA25255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C46C60877
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5eG69QmlV0J for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20D1960801
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792152966;
 b=LP2MhaLWd8ImyTlIf4s6HjHeipxJHp8RAT3zypfEQ80/rh6Et2fIpt3EPnTvb0weF5vd
 bZVG0rNQb8h3ukp2viS8/CsJREZyfGlDgYACQ96hxUykwcNirQ/ZHOFSf3K9oa7FueaOB
 x0Bj3ILJPVB1bjBGHKK0745xuG+xKHd+7od1aOTdKbqFd+evN5tBvsPy7L6HEPMdw3ZDK
 IkFxgm7dxEveOUMkTT3pD95ZwiZ53428T+qjiTkOGlDE+C2foYspyrDfh+CGWuXBG7d70
 DcqzHCpd8mCLztuZSIJtANP354ipdRwrKSsUNBUPJ48LjKDRwvAEIM0r/p0iu9XUrNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792152966;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=fW3YM83apiPkrnhDW20cNFxeHIIzzTEXZq1PadZYkc4=;
 b=pWLkLy79PeVDyybsqlFXiGyn7Ro0Uz2NfZ7qC7+R0JWXmvS+AxiBlHJ3MjzyOJoSKt9Q
 pL5wMawNHUzvmRjndLQrf1WFhIkqcxyS4jf7tFlQo136gKMzYCB0eh9dcgP17Ij3BjJU3
 yQ4NHElOhqGULzKi7qDkasbT3cl4U9b9Ju//NAeXpjdQXTdfB6XMjfytMMXOunm9ksj5R
 6efYuEzGk+OmJV7kDdXFJVHRx1NYr56/mb2GWm+tI52RVOwWocBSXyKOE+6bBc9YTrDGt
 S7tMb2rAjM6iwIK3SsTViMt7X9uFsvbalVy1jGhFv0y8gqb403oh8g0k75GnWgeasuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GrlYdLdb; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GrlYdLdb
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20D1960801
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4B5041974;
 Fri, 16 Oct 2026 12:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CA71F000C4;
 Fri, 16 Oct 2026 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792152964;
 bh=fW3YM83apiPkrnhDW20cNFxeHIIzzTEXZq1PadZYkc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GrlYdLdbV7I2Gu4J9somoRwvLC6VYG3cf97bhyWEDprXDPVkfoxrr0YX9OFIjhaR1
 QEmg9nh/dARDHslW5sz4uiJKLkZEck7VH76SMRXBlVbNDJU9DbziJnZ+UhFyAjj8QD
 yPYCwvlyvjb3wBBAvsRXIdZDf91PoleQlFYJZsh08nLdnzu5AyT9bJP/3cMNaKiK8W
 jbbKY5VTEbhBHRHfLpLFdIfILFjySYcZEjeckqcJn+Pms34Mf75pwLI0ORP3NeWBpU
 158EoYAGi7rhej5/MHzCsFZwSLfU+/QoTrGtqLFTF229ug7nZeP2+JR/m4+TC7H7iR
 vi7Dfcf5rn2Cw==
Date: Fri, 16 Oct 2026 17:45:56 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: Re: [PATCH RESEND v5 0/5] Add FIT multi-DTB selection for Qualcomm
Message-ID: <atIVfAF9YZ_Ocp7S@sumit-xelite>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
 <20261012175042.GD3722450@bill-the-cat>
 <6bff4593-8182-4524-be00-6963ed9330d4@oss.qualcomm.com>
 <20261013150307.GB4042005@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261013150307.GB4042005@bill-the-cat>
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

Hi Tom,

On Tue, 13 Oct 2026 at 09:03:07 -0600, Tom Rini wrote:
>On Tue, Oct 13, 2026 at 12:50:42PM +0530, Aswin Murugan wrote:
>>
>> On 10/12/2026 11:20 PM, Tom Rini wrote:
>> Hi Tom,
>> > On Mon, Oct 12, 2026 at 10:37:49PM +0530, Aswin Murugan wrote:
>> > > This series adds dynamic device tree selection from FIT images for
>> > > Qualcomm Snapdragon platforms, enabling U-Boot to select the
>> > > appropriate DTB based on hardware parameters detected at boot.
>> > >
>> > > Qualcomm FIT-based DTB format is documented in [1].
>> > >
>> > > The FIT image contains only DTBs, while the kernel is provided
>> > > separately as part of a UKI image.
>> > >
>> > > The implementation consists of:
>> > >
>> > > 1. Hardware detection infrastructure: Introduces the qcom,hwinfo
>> > >     driver and qcom_hwdetect helper to collect hardware identification
>> > >     data from SMEM, IMEM and TCSR into a single qcom_hw_params
>> > >     structure for consumers such as FIT multi-DTB selection.
>> > >
>> > > 2. FIT multi-DTB selection: Implements DTB selection based on the
>> > >     aggregated hardware information. The code parses metadata DTBs,
>> > >     matches FIT configurations against detected hardware attributes,
>> > >     applies overlays, and loads the selected DTB for EFI boot.
>> > >
>> > > [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
>> > >      Documentation.md
>> > >
>> > > ---
>> > >
>> > > Changes in v4:
>> > ... which was sent as v5, and this is a re-send of?
>> Yes, this is a resend of v4, which was sent as v5
>> > > 1. Drop the SMEM cache infrastructure.
>> > >
>> > > 2. misc: qcom: add qcom,hwinfo driver to provide a common interface
>> > >     for reading IMEM boot cookie and TCSR SOC version information.
>> > >
>> > > 3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
>> > >     information from SMEM, IMEM and TCSR into a single
>> > >     struct qcom_hw_params.
>> > >
>> > > 4. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
>> > >     of accessing SMEM, IMEM and TCSR data directly.
>> > >
>> > > 5. Separate hardware discovery from FIT parsing and DTB matching
>> > >     logic, reducing complexity and improving code organization.
>> > >
>> > > 6. Load FIT images directly from a raw GPT partition and remove the
>> > >     FAT filesystem image based loading approach.
>> > >
>> > > 7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
>> > >     related documentation updates.
>> > >
>> > > 8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
>> > >     qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes and
>> > >     board-specific offsets.
>> > >
>> > > Link to v3:
>> > > https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com/
>> > The FAT comments in v3 were addressed. I'm not really sure the discussion about if
>> > this approach makes sense as really was addressed however?
>>
>> Yes, the FAT-related comments from v3 were addressed in this
>> revision by dropping the FAT filesystem image-based loading
>> approach and loading FIT image directly from a raw GPT
>> partition.
>
>Right, thanks.
>
>> Regarding the broader design, the reasoning for using a
>> DTB-only FIT was discussed in the v3 thread [1]. The intention
>> is to support firmware-side DT selection while keeping DTB
>> management independent of kernel packaging, matching existing
>> Qualcomm deployment models. This is intended to coexist with,
>> rather than replace, approaches such as UKI DT bundling.
>>
>> [1]: https://lore.kernel.org/u-boot/afSXa7q7hJC_ZW07@sumit-xelite/
>
>Yes, and I'd appreciate some of the people that were discussing things
>in that thread chiming in and saying they're happy enough, as it wasn't
>clear to me in re-reading the thread yesterday that the discussion ended
>with agreement and instead just stopped.
>

As of now the Qualcomm subsystem maintenence is in really inactive state
as you can see from the list of patchsets even carrying review tags are
missing custodian attention here [1]. If you remember it from our earlier
private thread with Casey and Neil many months ago, the maintainence
situation hasn't improved at all.

Even as a reviewer for the Qcom subsystem, I have tried earlier with all
the reviews but patches were still floating on the list, which just
demotivated me from doing further reviews.

I would really like to get this maintainence situation fixed. Would it
be fine with you to accept me as a Qcom subsystem custodian with more
people from Qualcomm contributing as reviewers?

In the meantime why we decide on that, can you help with picking patches
which have been reviewed directly for the Qualcomm subsystem?

[1] https://patchwork.ozlabs.org/project/uboot/list/?delegate=151538&param=4&page=1

-Sumit
