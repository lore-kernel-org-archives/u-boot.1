Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38ABC9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 08:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2849980A68;
	Fri, 25 Sep 2026 08:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tedNWyzK1GNN; Fri, 25 Sep 2026 08:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5FC7780A83
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790324259;
	b=IaKNl+YYS+0MPif5VKogFLcb16ildSKw6iuuJRrTJq3pvxa8Z3PEu7R6VuPmanXX3mWH
	 ayBQYkWokFipFhLCq+6iRbOb5Cgjs14mYIUG3oYfCYMnpdo7Ew/dlPZC69vsKC33e3D6q
	 cYiIFOGHV7a2Pih63YiOKPGkQKpGyIQXdexOpO5I4fARrFaPL5klILO8OeE1xyiJ0eYAU
	 cj1dpTxOiVTS/i+FOesT6nvrD4ATuK4wwe/JNN8/XAmsP26GjvdD3eRgF+80/79tsmhM6
	 LHEoSnCpNd+kg0QOMBR9uL8Fu0eD+9YfnLEXRoLbYeRQu6mstOPCca32jiGp/EDZMjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790324259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0ef96O+dBLf9tm5ls7mhQCo3MhBeLd8zZrqyuMLvaxQ=;
	b=VoS12BcLQsQwSgOCwCmqIEeGTOYuq0qcr0q7UByNUvP+c60/YQv0hgCv+6jeJ6OqAvCT
	 8kDX3sD9cAoyDTL4DINZM7SzObxKHqHk3kONmyYZNQCjwkHlfpnIEaSnJXcZcvDsKyQUu
	 y0MWJIDneQaAMAFwqeQ3lgdf08nqpuj15ZrJQPeIz0Q/yVLfD5j6Y+PussE2loGO6cxVV
	 tn6lJp2xcyjziC5QaaOBFH6cIkEOCX0gm6ixrippSt/zrq1PteaWE+zDio3YihvXjvO+B
	 BkBmm5F/nT1hFkj4JlbIlHrSQ/02d0PJTuDgu5wjpmLj4EohB19U8XI0/J1xUYlYUWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790324259;
	bh=0ef96O+dBLf9tm5ls7mhQCo3MhBeLd8zZrqyuMLvaxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uQOXkI44nkk817q2/dQP5K2a22SvZLkWHnmg2dmpm3sDt0ciWKPVJOMQXi/K5YXwa
	 kYESCv06YbDbkX9u+PWOH0A3ynfl3d6fy7mYUSbSlrdcpS+dLCv54ILYSrZdx8eMFZ
	 ZHY1Xd0s2KUwdM2bGtHt6bpSoqTIhtPA8TvcXg+Fs52otWtFqy83eKozde5GSsqCTc
	 tcEUFTCZrtJN//ioPhvFwO1tIYYMl9IAjizgqmVGPa1Nto9OD/5X+5+cHMYxdeEc4C
	 NccV3tMOzQaAKZiuvAdN2eAs+j95Z6OFT7gCXMSijj/uFvVhKryixKJdj//ouzYTSu
	 VZlAwL1S1CC2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FC7780A83;
	Fri, 25 Sep 2026 08:17:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3DC135A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 08:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D609D60B65
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 08:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_QnqHH3LumW for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 08:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2E8FD607EE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790324257;
 b=VxJq8//NLTTEplEln4satTrX3fhOFwHyVDgIXWl0KhavNIsBhzhdknZP/1WN31ySDJGX
 XFeeuAcYcLfS/Vp+Q0hF33Kr5P4afpP8RrXQjdA73f/sHthCiGFDMgxlhsYRau5xDQZZD
 PSZJlqL0XJeWCg5765WlimVIxu+UE0HRh9voqjfeGXBx+g/l/TX8fIwA5aP3y15pCCS/r
 +6KGDfpHZwXCjpcMnO2IYG8osM3ne4W/6h0Hk/nTv3ViHDw4bWwvDMA82foosL7lihGkE
 aDFBGOO+lZjGEcbPRZCHupplo46l+HMQwwq80EJbWQad0vK9D8s9jMPes3uOzk45dYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790324257;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=0ef96O+dBLf9tm5ls7mhQCo3MhBeLd8zZrqyuMLvaxQ=;
 b=mmgbjtzuORPDeza7VNdmSbCrcZfvOZxBbjnojQw71Aciumm9DfVnGgqjOeI7Q+gBcEI7
 DHwirwtKxkyQg1OCG5ah9TEudmCN5TAPtM/d5Zsfp2MpA8/5TDGZntxHEWE3sKYlXPqmB
 /t65UNv2gAqVeZDf/w/6cVEtpkq8jugdOT/B8kARNFUlZRmmTSPB+HxxK61PEaIibf+Af
 rjchWQIEoCLD9hTH/ydLpz3+Uhhirx/AsvMOb938IO9TlVOQDIiRIB4lcDcdCT9jsPtg/
 RWEM5Sj4Wx4gdEH8Y4xqGyX3XrgJ5b0f+yz9YzVI1y+ID0Tcr2yoWAVx4dAuhBBmjCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L1ywCZrF; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L1ywCZrF
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E8FD607EE
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 08:17:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A62D41275;
 Fri, 25 Sep 2026 08:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC261F0089A;
 Fri, 25 Sep 2026 08:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790324255;
 bh=0ef96O+dBLf9tm5ls7mhQCo3MhBeLd8zZrqyuMLvaxQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=L1ywCZrFrPn7Lo4t+tr1+AQ6XLxmWyCFWjzlgek8Gat/i9tdkY0B5Fz+k7IDBXusj
 zKP0CqbN2po1lZvLioeGpnTDXrTa9o35wTSA2IhBfo140M+qzKfdRyVjwKtV8dG01w
 QjhOo8RN6p71B0JD75Zx0JgDKOtbz9405DhlFslAegp6Sgvc+zGFaSaZ482mhdFVvP
 c+p5KRwl4Ao6RgbX17q0cbRB9sqJ/E6qFrzKYPSnNWBEEzLuIxSdg+Hv2wQQOahq8R
 M5U0lyyGRDZoatRxFiSZ9ATn51CKIhoES6jnQQ0OGPoClhlP8LdB3pPS8lXvk/VIkG
 jyRuH5mNw4+IA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Synchronously tear
 interface down
In-Reply-To: <7c93c6c5-2d94-46d9-a73e-400837be370a@nabladev.com>
References: <20260903020231.1278473-1-marex@nabladev.com>
 <87o6e9tpm4.fsf@kernel.org>
 <7c93c6c5-2d94-46d9-a73e-400837be370a@nabladev.com>
Date: Fri, 25 Sep 2026 10:17:33 +0200
Message-ID: <xhkdb33uxsq1u.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

On Thu, Sep 24, 2026 at 23:14, Marek Vasut <marex@nabladev.com> wrote:

> On 9/7/26 10:47 AM, Mattijs Korpershoek wrote:
>
> Hello Mattijs,
>
>> Thank you for the patch.
>> 
>> On Thu, Sep 03, 2026 at 04:02, Marek Vasut <marex@nabladev.com> wrote:
>> 
>>> After fsg_unbind() is called on UMS teardown, the fsg_main_thread()
>>> which also invokes handle_exception() is unlikely to run afterward.
>>> Therefore, any exceptions raised in fsg_unbind(), and also exceptions
>>> raised in fsg_common_release() which is called from both fsg_unbind()
>>> and fsg_common_init() fail path, will remain unhandled.
>>>
>>> This leads to a problem where FSG_STATE_TERMINATED/EXIT handling is
>>> not performed on UMS exit and the do_set_interface(..., NULL) which
>>> shuts down endpoints is also not performed, leaving the endpoints
>>> enabled.
>>>
>>> The CI UDC driver does check for repeated enablement of endpoints and
>>> returns -EBUSY if an endpoint is enabled repeatedly. That prevents
>>> UMS from being started after it was exited once already. That is,
>>> running "ums 0 mmc 0 ; ums 0 mmc 0" on U-Boot command line will lead
>>> to one successful and one failed UMS session. The later session ends
>>> up triggering fsg_is_set() assertion in fsg_setup() and triggers a
>>> panic().
>>>
>>> Fix this by synchronously invoking the do_set_interface() from both
>>> fsg_unbind() and fsg_common_release(). That makes the unbind behave
>>> as intended, as if the fsg_main_thread() ran after fsg_unbind() and
>>> handled the outstanding raised exceptions.
>>>
>>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> 
>> The change looks fine to me. I hard a hard time understanding why there
>> was not an equivalent fix in Linux.
>> I think it's because we have cyclic in U-Boot and real threading in the
>> kernel.
>> 
>> In any case:
>> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Maybe this could be added into 2026.10 release ?

I'm sorry, this completely dissapeared from my radar (It was not
assigned to me on patchwork).

I'll queue it up.

Thanks for the reminder
Mattijs
