Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C5AC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 05:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A300380DCA;
	Wed, 16 Sep 2026 05:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6yAqwXGYIbGo; Wed, 16 Sep 2026 05:00:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D438980D8A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789534824;
	b=XatOdd3OSAWtsIuYrz/oOtiYJ34e82Jw7Rc23e2ykZYaf0urbYhbqdKA+iGLas0yw8px
	 RQdQtT3RKhGMbYRpJ2+f0a5k0Hw65Jiy28zGEvvz1tneV8xGPuWi3N3jz4awZnd/H1DKu
	 Dg4WXsE9Q+Lme6KVj2ygfepYufiZhUf5qaQqjCGt+30hjmBFk9yjcIGtTvOGq408sNE9n
	 qQ5irzur/hgQNcONbwu4lJ3JUDHejJYogyqUAtK+fXya1GPcVQ4bO8o2+A3YD+ZuXpGOH
	 HHkKGL67+H+FtTFBuvwykjt5ousXdDtQi+nA8y+Q382+0KIW+1f8j9S//lBbcOX4dVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789534824;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h8kf/jEJa/aL0tbt7P3CfsM0py+ebdPAyDiDRlo30Ek=;
	b=H+OPz419+aETnIC8tRLrNLJJRSOR9clgABXIQ5BSunRoBVaJm1UVx6Wk51+S1vDP+qCU
	 /bFzDKK+jcV1De3L0EecwTXv+c79jvMl8e23WmUCtx07NIyhxMIfjMFRacbunAM0c9an6
	 CPt/ggJpJephPA2jdMp85shnIBElcuBQ3/bDlMoRzSOEKYS0r6yGrr10tYEkmaRAN4a1Z
	 pwNAROQDWjmDLm8sIfmAoMCXahxNLb5WXpVqKZuPb2Zc56SRKvNXiMRZP0Ze10Ns8p6KP
	 Uzl4AuivDOTYkpldLMTqLyUaD+B/eOIHE1pWY+jZ6pVVjDEHaIr3j+3H2qWYnv9Drxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=C8qeXvsp;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bPHe+MHH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789534824;
	bh=h8kf/jEJa/aL0tbt7P3CfsM0py+ebdPAyDiDRlo30Ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DsEajacVU/g4WMYZXVUtSFYIQ+ATba77MMeG34kKWkxCsmSfYSrXE2Pdso9Kq9lI1
	 K3inHeN2IRAMPaLs1jjrP9QWnjkHRD82UsvqSth/dRmlK7RJgqm3pt7/0YMwUK1wNl
	 X1RcVa1PIX9gUV5DOi+smsbt1ndyfILBwiWFR0qeC2QGUF/lmAidlclcYw5Cw0bKUK
	 CifRg8CfqOvDx7VYC5mfbz30x0m9v7x6hVEHQnm9A4susaRFH9ixq1ds3jlm3Fvmhr
	 fkJ3zT9L3UxHfStAo9UdNCB/CPmqM9LFeXoqpqJGy8pAUw9YgvBXXjA2yT8soxlaTG
	 a5hgr0jBdzG5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D438980D8A;
	Wed, 16 Sep 2026 05:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61242224
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 439EC80DAE
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buF9TznIIZXc for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 05:00:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B314F80D7F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789534821;
 b=ijBrD4MBUsGzq75CwMP5yG1nuxaubNFJ6jCI+YjcQ88/325ab1kHjxtDj2dOU4wgNVjz
 0Mv2eWDqEa0J6t1FWTK5UKkYT61zSvC3vmu0lG6GifVLzashX7hZseXrbzJX+vdm9boE4
 U0qi7IEHdmIWzL1gpdkwq7uV3pWS6RGFNboayiAo3+y490dtpu+PtJ7hywUZ6L5av4tdK
 71gf6MXqc+6ywpt1av9RxXbhIU8J83Atw2feLyyF6tuDC+V/fX0PVK3zrYY4z4EEs6mXB
 wXEDfrRouGNS1lVFKe2NOLSuBO9x7f8cCR9SZVTe2jO9I8uFjMCYr+4hekdV/xLsfIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789534821;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=h8kf/jEJa/aL0tbt7P3CfsM0py+ebdPAyDiDRlo30Ek=;
 b=b8y83E2jHSKEYkSJmiGci+sQcDtu7lRESGozbOX7ikpeEBoZhEcjFv42yXCXOO/CKorL
 Wf0BOxNDmkcXbtVMPNj+LmoleGqQOHKQu5VQqu83qt1CO5yS46wr+RO1j92Ephalug466
 NuaiesohngZcb8C77r24j52d4HRBwvsbQtfzulE6lUG3vxrN0HCh5n1OfAOEeZyY8PN5Q
 37F297CYuOkLoQPmzA9l4b/8cvyTl8NN0F+liqWvgJdAx7zvPEsJQAM2EIV0LHfTPgbdK
 usUPR71ron4g3sYiA3Ssw+xdXw99YONz4Jn2Z9sRrFmySrN3aXkYwnb0vpz4OI+IHWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=C8qeXvsp; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=bPHe+MHH; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=C8qeXvsp; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=bPHe+MHH
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B314F80D7F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:00:20 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hl6C50mKLzMlJp;
 Wed, 16 Sep 2026 07:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789534817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8kf/jEJa/aL0tbt7P3CfsM0py+ebdPAyDiDRlo30Ek=;
 b=C8qeXvspjc5KMcTH14RmhElp38yY4BcTyK4FK/olY71wfkvRHa2MeOBDl2DiHzoV4MdfRm
 VVKkcJ/AvwrxcZWE0hpGJ6Z7U6kTarE97XgqT6Q0MA3ig9w2yJ5XGGAYj/Weyhz/9yqfN6
 7eyuBrEGt/shw0CggROHnjSDgAhNyAONz/xuAifXaECQeZK73D2W2fQbw6h5m+SVz4Usu0
 mrG+6oUJrWNxfs7J61s5YF8+E+g2b+VfBKor4ZFo1LjPDqSQQhkeImmmWfbFZVixNGfEms
 Orh6v1A7hSsMhPjj3HWiQa62Hgf/QKJLLTEh7sD5Fa4fepFK9f9viUUK6VB5Wg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bPHe+MHH;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <425b3ab2-1d26-4641-8f52-714088a2d25e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789534815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8kf/jEJa/aL0tbt7P3CfsM0py+ebdPAyDiDRlo30Ek=;
 b=bPHe+MHH593w+x4qwtuYpx0KXbbjZN26Nt7/fvVVHxpbjstx12mWroQAEQmCVhORimExiG
 vtGAC3YF095Penz6bVmeu2blS6epkXUa/XOhsEgymxOKD2AWQeGdQbG/mM8PmaxfJYkNak
 FBOFiiVuoSKRUQHNNYATqbBumrV04tJ6p2xGikpXr0fYZ8/2kl2LiCTyx+V6RE3pKiFto1
 eH2qR2lEm7yTw8naJC58T1CswFr9bDVHiKRCX4ev7fHV2ebVLDieIL+bl9ci8fiaz8XhvI
 ySaQZfz7ouZ1C7my4x1uZ2toY//7vEdrnuW/F00Q+ag6zpTGNcLsL2Fz0KXvAA==
Date: Tue, 15 Sep 2026 16:24:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/7] usb: skip host-only devices when picking the ehci
 gadget controller
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 u-boot@lists.u-boot-project.org
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-5-eichest@gmail.com>
 <7afa5ce4-060c-4bde-a820-2a579a0fad12@mailbox.org>
 <aqj6TwcnEeDZGQxb@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aqj6TwcnEeDZGQxb@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zqy3hg4hmpufd3esda8mf9bj8tubjpbc
X-MBO-RS-ID: f3d03fa9313c838438f
X-Rspamd-Queue-Id: 4hl6C50mKLzMlJp
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

On 9/15/26 9:57 AM, Stefan Eichenberger wrote:
> On Mon, Sep 14, 2026 at 09:31:25PM +0200, Marek Vasut wrote:
>> On 9/14/26 9:42 AM, Stefan Eichenberger wrote:
>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>
>>> The i.MX95 SoC has two USB controllers, a DWC3 controller and a ChipIdea
>>> controller. However, U-Boot might select a controller that is marked as
>>> host only in the device tree when attempting to set up a USB gadget,
>>> leading to failures in gadget mode.
>>>
>>> Iterate over usb devices and skipping any that are marked host-only when
>>> selecting the controller for gadget mode. This ensures that a controller
>>> that is marked as device or otg is used for USB gadget functionality.
>>>
>>> Verified on Verdin iMX95 hardware: "ums 0 mmc 0" now correctly flips
>>> the ChipIdea OTG controller into device mode and enumerates on the
>>> host PC.
>>
>> What was the previous incorrect behavior ?
> 
> When I did a ums 0 mmc 0, the host only DWC3 controller was selected. It
> is not host only by itself, but it is marked as host only for our board
> in the device tree.
> 
>>
>> Does your board DT have /aliases { usb0 = &... } entry pointing to the
>> chipidea controller already ? The controller indexing should match the
>> aliases ordering.
> 
> Yes we use aliases. Interstingly the dwc3 controller is usb1 and the
> chipidea controller is usb0.
> 
> aliases {
> 	...
> 	usb0 = &usb2;
> 	usb1 = &usb3;
> 	...
> };
> 
> &usb2 {
> 	dr_mode = "otg";
> 	...
> };
> 
> &usb3 {
> 	...
> 	&usb3_dwc3 {
> 		dr_mode = "host";
> 	};
> 	...
> };
> 
> So it seems this ordering is not respected when selecting the controller
> for gadget mode. I have to test that again. However, I still think host
> only devices should never be selected for gadget mode which is what this
> patch tries to address. Or should e.g. ums 1 mmc 0 just fail for host
> only controllers?

Yes

> In this scenario I assume the ordering is correct so
> ums 1 would select the dwc3 host only controller.
The ordering should respect the aliases enumeration, so ums 0 ... is CI 
HDRC and ums 1 is DWC3 . Can you check the U-Boot control DT /aliases 
node to be sure the ordering there is as expected ?

=> fdt addr $fdtcontroladdr
=> fdt print /aliases
