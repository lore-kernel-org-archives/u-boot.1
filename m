Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EA8C79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2066B6075A;
	Wed,  9 Sep 2026 09:10:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogoGGOA7W7QU; Wed,  9 Sep 2026 09:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 10CED606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788945034;
	b=iXgHZt4rxZTNfYgVzAjQszSmiL59N1oi3hIbfRSkBZ8j8gOQIPcNwQFkUK2ovbmhUEE4
	 DSxpuvOGNcQ8TMpDI4BVLQR1Lim2eScV9ZO9HttUgv7SycrJiOaZps6TC7KxAjE3hqAYp
	 tNunS24BIAEXhXMbKm0KMI5qdS9U8+hwRl/KJNzIOwd2YzXiZV4uiflJ/PHMk61x7Oi1O
	 oStv5uszkksp6qrCblc0FdNG77Kj7CSF5BVklaip2f7fZSW5jhiHizeWJJDy3wTqHHS8/
	 oO4g5dmoiHm58wDCJqMkjSDju9u4wsk6GIiPBK53/KUr/HojGcSQw5GDoKQA4v4CSTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788945034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VoIY69xmgKZ3P6g6BJ2kBJQZjrMFqm5uO1H6JzHEZck=;
	b=qbjXjOEpgIaYJNI57aZDRq5ku48sCI3RTwoE9eNJJoS3hxIAomkRi6MYcs8Mx0W2DyFQ
	 LdYb++U1NN4cvhx6RXcNhHIwOIZlY7I5YUGJvfFVIoljHNGP8HA3bMzptEGYopFJafdG6
	 hfHREGHFAZCJWcSRDy7kdG+J/mKM/+uh53rxgXWWSk6pQxm6pcX4oRMHVxZmISfpci9/8
	 NeNszTcPd8dmTgvhz+W4jienFIvBmvBcONmcXhgEi+Gd+GxiiG65jTYjmVEpRCKPIDHfq
	 3Y7S/rofiKYXJYiz3iAQIgeVTolEglWGxMb/S4zZHczHoYGUwvPuuP8v5PiDFveQL7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788945034;
	bh=VoIY69xmgKZ3P6g6BJ2kBJQZjrMFqm5uO1H6JzHEZck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ct7PwtraTaeCLUVia5OAMcEw7/AeccIdzTKxqj4ZkIst6rVMhKMIEWXq/ptxrDE/C
	 maMJXTmqnRWEdtffngZNBP976PmCN9c48zS1dJ2U7ajPYUJ0EiPUNnjRS9a4GtO/XX
	 Wc2oUh2M8kx8krsVp/9IOsQ/vZY91efeHcL4naC2oCkA7NdggHqzlOVeLlxxsvcfaD
	 3OxQfscoNHTG2HYEeHIAGmCot7CCnviRBYyuhsjMqkQ4jVRnKJgo/UKezD0TqlFDFZ
	 XRYVdBPHdW3B0NJiH9TJfYIdu+kzaIrl60+VUtibBGZSq9CDrluTM7Lv31maMQZKyT
	 2D9S5CWBBpniw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10CED606CE;
	Wed,  9 Sep 2026 09:10:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48C10755
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A40780D58
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOdjkM_bsN8x for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:10:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A4C7A80CDE
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788945032;
 b=GxXKRMpM3jXX22isQsbx+5J2cxZQ3bxsPormSNgXt6vC7Zz97EjReIhWj9Foxe4Ulueg
 bnHws0tn3mpxZoqc0gCFqDXnV82aZKo6w3BngldtFkACznHvFkbJL3PlZwm4TO6n6QjyY
 2Gcyax6fzXYMA1aq8Gt5cVr9k2x3jGC0DQXiBigfk7oF+1fhzEip/LLjEHYA/oVxlkCg1
 U8lD7mXxlIhBSVDtj9tP+Nj+LQsH4YAJwx6yhBbafEssW+Ig1RRi9X8d6Fzx3jc9HFduX
 JyEy4Fre4/mlOoMPhwcw5xJbpO5JuS/DFF/LuYEgJLgiCLwImqYiStK/wkuNoupY05Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788945032;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=VoIY69xmgKZ3P6g6BJ2kBJQZjrMFqm5uO1H6JzHEZck=;
 b=lxOLohkCeSytN7hHWMlLi/TKaAAl5CZyk4X1MKsMrW3z606BDJX1CFLz9AouK6/Yx+de
 E9ttABCUduGW9NJRXV4DSdkcC/yXx/iyYZVsv/zWn1jJ9xxGfj8q5jAmVyuHWmo+kkWXO
 0Yr1Am+btJEdyW4dAdlV8BFbErKeP8xHcOsJLZx/b3KJCWCvPNt381ELWhe4rv2bHAToy
 jleRQTdY5ekIgZUSgRpmJoNSGLUBErBDEIodZBFmaTu1WmQOaisq6AcO1hj8pKSmUxdQ2
 2/Cp+uFytNbRLXZ296vqbPPAqzgRPaXJTcSDMVv/V960P12vIgSfqhSLJQDD9lydWYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="o2S5N/V0"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=o2S5N/V0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4C7A80CDE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:10:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4146A41A4F;
 Wed,  9 Sep 2026 09:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E971F00A3A;
 Wed,  9 Sep 2026 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945030;
 bh=VoIY69xmgKZ3P6g6BJ2kBJQZjrMFqm5uO1H6JzHEZck=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=o2S5N/V0Z14rerjzX6cAghK1iA04z77pX5t78jcxz0/qhNQZ98vIExlTtdsgSVx+v
 txUJVZMy6lbLMxXIZUF6RrNLCO0TJPkUR+1TeYRr/y68KiLG2Wo6NcyMdjAj/E8hZb
 l+fecLnWKLLk2Itz0IXAlYO5BOP3T20lRb42pJrKvQRwlGmatkfkpV4IyHUDesg4I7
 ObIMK4IeEiwr01FcJKykFMfgR+jeLvRHGHFO/GhdpnlfE8WTBO2WyWAwIJH3jcwkGU
 pj6Xps6eeGK8toUHz86yLAtotKFKqQX/p29ct99mdSjIcphasJB06ARxH/2/3qL8P4
 Bj2TxezhKSHTg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Dan Tran <Dan.Tran1@synopsys.com>, Lukasz
 Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
In-Reply-To: <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
Date: Wed, 09 Sep 2026 11:10:27 +0200
Message-ID: <87wlsu6b98.fsf@kernel.org>
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

Hi Thinh,

Thank you for the patch.

On Fri, Sep 04, 2026 at 02:29, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> From: Dan Tran <trandan@synopsys.com>
>
> Add SS bulk endpoint descriptors (1024-byte MPS, bMaxBurst=15) to
> storage_common.c to support SuperSpeed connections. Extend fsg_ep_desc()
> to select them when operating at SuperSpeed, and wire up ss_descriptors
> in fsg_bind(). Free ss_descriptors in fsg_unbind() to match.
>
> Signed-off-by: Dan Tran <trandan@synopsys.com>
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
