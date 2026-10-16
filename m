Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69255CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A175607E8;
	Fri, 16 Oct 2026 12:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfDsj5GHiLaf; Fri, 16 Oct 2026 12:27:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5CB4B608C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792153668;
	b=qF4HQKVlQADIYN7E0qkOH3mtEN26kHBEg0n9MV/4RefvkbNmRBuAxNm7uvMp6g8bWPjf
	 SbFA8ciyHb5Rypnb96fZrAnT/Mu5h1ptCdGmI6giqAW4G3Xh+2mcQSpWCJrssAMBBxFbN
	 04j3igJB+YaxqDLAxEaRZgbo7U7EZOeQ0YroOof9PIqqaaDycAyQ0QEpXeizzdLg573hw
	 3QsEPyjkjqrfvdQkfiTBNms9lQYT6YKgPPpYpvW3xieX3tIyCL1/AnPLl6sqKIqVuNnrY
	 gYPGBggbWzzfg69pO9YVm+zdV8TuF+voLPnEGATmCmM+zGragGzVCB5yeJCVz19D2rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792153668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3E/V5HvGDCVn/mYea9pC5pNE9IPBxi1F4xTUH5c5d7g=;
	b=qYvay8JP874a4lv8ekCNQh13VLz8Mr6KOkvK+fnX03PXkcP8MtPZsdNlU3Ypksf544xh
	 FZA/EZOJstF/OtJlrDw3eyWM7lRiNz4xKXnvmh0HmnsNYRf4biQqqCI8tweXjgb26UACu
	 b5hcXPg9x44ncaFy0M+7CbCetetw2peyzB9fAjqF5Ph5f+We1PQaqLaN5AlfYCqWancvy
	 vuM9LfNby6hHrgcLOA6XLazhTBtyTb8EIhFtiyA5OmDqqQSdIqXrEtaSPkZ7X+VzbJEDH
	 fl3DvPXEhPxuYkPHnDR0O8r4YDLi5CeXjEPCY7RMCD5is8G8YB4bxIZCMciGpefK6tA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792153668;
	bh=3E/V5HvGDCVn/mYea9pC5pNE9IPBxi1F4xTUH5c5d7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EzXI0wcg3rMl9mEV2VzR5BiZwfY9qq4M4KYqASnKVtuWyPKOPDdd/H7RmqdeFJwyj
	 YwVCKkw8hCuWomIwfSFg2MT7CaD9zV5SmFM1zjLFOuJXjrN+B1BuR/S5+Lcxm2+J5z
	 ZLGWFsscp/NEe5BGTmQH5UJnobyKQPAqKsU9Ql8yipKKtc15lfwEuYvWnhwlS5wTZe
	 GzaBj18P1aCm6X8MyTHihgyembvHl72WU4mSOSZ2Etrzow/5Faa1nNibB5vXY5uB+h
	 1phbtsCOHw7vAfGG8pEF781EB81zj+eh/vYkuP2I2jqA7u3V+xKd7QA//OVS6w+5os
	 3wMQY5lniFS9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CB4B608C4;
	Fri, 16 Oct 2026 12:27:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9E59109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F0758146D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFEiecMHpH0u for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07678813F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792153667;
 b=NSthzFz39gPZpC2VGykBz9+eZ5n1wbQ1+YL3dCn34SzaX5CqkrXdp6iynJoTFCq2UK2y
 Va17onLdVZOrhocMa1KILdqamVFjDe043Vp4yJgDKkHNHAmpYG0z/HE25BNdc4wYq5FQH
 YejipAwrxr4jaojRz8FS1fhNZsQwXQAm+i4bBEQcx3AdIS0AWeQoxMC+kcX6QyJi7act0
 z3za3NaDtp+5y9dlhpy2ZxGc+S1IMP3dyx5eSr63nGRIv1jtw+k5Xd0JfLrlZA+onNaT5
 11dsMGinfXUZupjGv0K/Hs3OiEZBGdNHNMd8UCNd0mHju5JYitSMiLP1PBNVY6krCLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792153667;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=3E/V5HvGDCVn/mYea9pC5pNE9IPBxi1F4xTUH5c5d7g=;
 b=D1HgHdDI1ux2lymuwBr6lv/PAp/28zI48mF+on6n2SdgZ5+QpLAZnWg0jb+4s1OLB268
 qh/x2fUkuzxd1H8nnY9d4fUnb+BE1F2vklX6aLKSp68e1NTh2SHS5dgs5C1ieWoGqRWsu
 8teSLEspkUyAPV1w+VwDrOPur+f+mbI0ye5RilW5SjyR1DH/2oIz18oMo2g6kUz1vDLUA
 qQL5Ta4IINvwj3a4HKfvCucJE9lXEVmT7hIGGUamR6XDczhghYgNLvxHSfspbOFIpnqZg
 ssthd+UxIPva7GkVyOYDC1gxX1dfV5uWD10YPyAP4zJzTDG4d3iWwM3dzYLtjVr8WXg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lxgT2Dc4; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lxgT2Dc4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07678813F8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:27:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91507437F7;
 Fri, 16 Oct 2026 12:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3131F000C4;
 Fri, 16 Oct 2026 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792153664;
 bh=3E/V5HvGDCVn/mYea9pC5pNE9IPBxi1F4xTUH5c5d7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lxgT2Dc4FvIHCQrcQjlp5X4A928ANSNo/7HG1B/RxY9FY+3Ae35+GZDC3M1HgRKPu
 xJWM3Vi7o2vINCRJ2yoU6ayIAwxU7VvrtS3ISLxay1oJS1Dv+HMglldlJIyWbOkWD5
 wC1GpUtOl4XtPAYT8koUFx6KEr3FaK6AoPxo+OiwKjjkTVlfmM9JeH9uE0xOKjMc05
 dtA07yO6ti0wgQ+U5qbC1cZute/1+8qxD0DyiXwgFWtajNcBlWc+i57Ugoq69hwkkt
 w2xTh4cNUrindpcbgc3rjIAXlYfYfXhONz97S42nXAuNhDGY8hZZ4U9hArHdRi5BrN
 xMlyv8RArKe5A==
Date: Fri, 16 Oct 2026 17:57:39 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH RESEND] configs: qualcomm: Add verified boot config
 fragment
Message-ID: <atIYOzzNwGR21xby@sumit-xelite>
References: <20261013-verified-boot-v1-1-df1fa48a7ac2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261013-verified-boot-v1-1-df1fa48a7ac2@oss.qualcomm.com>
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

On Tue, 13 Oct 2026 at 21:26:37 +0530, Balaji Selvanathan wrote:
>Add a common configuration fragment enabling RSA-based FIT image
>signature verification and the required hash algorithms, for reuse
>across Qualcomm boards that verify a signed kernel FIT image
>(kernel + DTB + initramfs) as part of verified boot.
>
>Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>---
> configs/qcom_verified_boot.config | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/configs/qcom_verified_boot.config b/configs/qcom_verified_boot.config
>new file mode 100644
>index 00000000000..8aff098944c
>--- /dev/null
>+++ b/configs/qcom_verified_boot.config
>@@ -0,0 +1,6 @@
>+# Enables Verified Boot support
>+CONFIG_RSA=y
>+CONFIG_FIT_SIGNATURE=y
>+CONFIG_FIT_RSASSA_PSS=y
>+CONFIG_SHA512=y
>+CONFIG_SHA384=y

Rather put config fragments under board/qualcomm/ like all others.

-Sumit

>
>---
>base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
>change-id: 20261013-verified-boot-83c01372fee5
>
>Best regards,
>-- 
>Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
