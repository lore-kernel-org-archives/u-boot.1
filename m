Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657ADC98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 10:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1223260645;
	Thu, 24 Sep 2026 10:24:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AoPyEMO-n11O; Thu, 24 Sep 2026 10:24:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C23960B59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790245462;
	b=gA5B4d4HonFf5Bhf3MLCj0hpoAIXx0I7xattpJrAEfBGPGvtmWynC7lyd1T052YMvkGU
	 6A2aSuiux551YtFObgCNWLtzfu99ULRVyhJ5UO9Wqc59rlWmRR/0nGbQ6laOc0fO3lG3s
	 cfpH1LPScbHRur5HU2kWLCr9ZzE8tKzE929Wr7svI4wZd/vXnsxR4c0ctYr+uoE9iY3mg
	 2G6n3byHlhuiv2Z1PmFckd3gps5Hl5VbXnXfgFpO4B6ln5xCFk+HXrtA8T8Aph38Mtta+
	 tm/oSFs5NP2WAOgWsNhq6xuVOLOdGHz7n7B9u/uEoG093kNa9wc25lrf5zkmQ7dXiHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790245462;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1gGpTe9N9OSUAj/l4X8VONheeiwcD+1AbGtF75zoK/8=;
	b=oNA58U1jcs1UgGLKZ6FNdYcT24cf/WYyMijbO7v09wna/OcG/ppd2hYcM5IFE8nJlOBX
	 oxpzhw3lRU16TmNEdHefC7jVg5kZLX3vSGPkw2x0bU+2OyHrLINeaPDkMNMrcosmYIE+y
	 Gl7Vb8l6xz5yI8JuF3vkGgYycRRR39ZqowNedX4aFHAJVfzK8v6FBQ7s8yzERsZF0ZYug
	 37pKkT95UZOPmsInJvOrGCiJDSA2EGGRQstQ2cK0iYGj/5OoOXYPZuUqSjOX7Q5p0lU2E
	 KjLjguDMvP4ZRH7zKXdEqP8hkFZADP8BPBPyIMZx6zn6GsIYln3f1igrORLAP5H719g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=KobS5w43;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=JbovK0W0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790245462;
	bh=1gGpTe9N9OSUAj/l4X8VONheeiwcD+1AbGtF75zoK/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aYOtY0q1aBOiOChJPC+CBXt1KPRYaSDdk0Bdrgkn3vC4fwU+/IabBx0j1r7fTW02d
	 CUsQ1MdquvoU2ey4evUhqD4DyCOZZ1/fbQYlo+6/5FVnArPwi8uVXn+6K8a37vXyUc
	 V1PIRXfLCvOza/qxjz13NKUSOcVWP9KYxSeacG6DfitVLEOiMGgdjRCuszdtBgB+uj
	 YjVU3WuGWr0mMb2aP56Y8Jrhja5WIKVUejrJdX2jIRmEsN43t09yJdtA2hGVQj5DpB
	 RF8Hpbbyy9kyIuSKCpFfJ6qfALP7GHL1nAD3AS32euy6FlfmaqQ0xXHRghNdod7odl
	 5TX5IPnRpAUGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C23960B59;
	Thu, 24 Sep 2026 10:24:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1160E1344
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB27C60B59
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rmDgrReTSkvW for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 10:24:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 103CA60645
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790245459;
 b=PEb7Pn1HgJhBJnVoxcyShht7lrizn53Fs0R2DlDkezV32K9Gm3u6rFH9H13GAmmgSrwV
 H71d7G6pHpfngEkEp9VGmgL9xlbbME2bju/zpDz6HP5qAoyg/8pvD3QyvD0ysDBuU9HcR
 kuS0IERF6iMuvFoFK9BMvDn/ou/YU0eM8OBO9DSTjvh17ePurWDZYy1kL9aYA/Gz6cfjS
 goJsfSQdGA0nZgus3wVvWf/30LR2pujflCEkSLtjKrnJQHSl22HERNUakr3RGrPzbsUQ0
 UyAOz0rv9BW5aSpvSo0Dm2bmy6uK76+uj8u5zzjw5v3IRFKtZ5vcb7kt6q/+WrPgKyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790245459;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=1gGpTe9N9OSUAj/l4X8VONheeiwcD+1AbGtF75zoK/8=;
 b=SKVkzKNvELMMq8wEn+XMMSJsBebhpHJ3YDY1tVtOXaxZlRDU7cte60mUw6mkxDbA04+3
 5ut91VWiPFSJYTuqLK5IhE3q/iEiKrI3UkBp4f9KxxNchlVPxqzJsDO3mfMfrqDWK1Dhd
 +RikdK5ns9rHNKMYgGTwI/SA3DZKWXrcE33Q0O73BylVp3MLhEZePbevUvQCpdeRR/How
 4YFoDhqnoF5Dtft74mOltcuz/i2sQkyYf3Xy/TyiOv8Hlj/ydQZJpKjtJ0kdBsD0cKCaQ
 D05oFgjOxAZzus+i+ht42gBZksTJRkBTBJ4bPRCqkDVZ1+Tzd1mU6qDxaQjqhY23rBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=embetrix.com; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=KobS5w43; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=JbovK0W0; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=KobS5w43; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=JbovK0W0
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 103CA60645
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790245448;
 x=1790850248; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=1gGpTe9N9OSUAj/l4X8VONheeiwcD+1AbGtF75zoK/8=;
 b=KobS5w43I3WITX7nGa+0DnE3JkJ1FjXqdodOTVfIgZMN5/YeFBYA3arW1iRFJabUURz5lWsYCko/S
 fiMu3IHruUIVnrf21DaG3Ok6Z6mQoPa5ZyLtfGpRv6Z1N9p0gWkCE1+1AYpKV0Qmktpbli5om3reye
 Fvg5fj8D+0dFnw+qok5uL6GRkDGzktChCt3SxFQ5A+X7UmzZbDfH/POo6wFlG+dmZb+QMWNrdL5otL
 A8++M5c8w9eITkAKi9TDvH0HsvC2J6JNkzgUqjNjcFTy1VYS/iUNBPqGrO098QX+AwYSPAHxc6yfN8
 MShVXY01chhbAhO4+tlCdMOd97y1yzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790245448;
 x=1790850248; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=1gGpTe9N9OSUAj/l4X8VONheeiwcD+1AbGtF75zoK/8=;
 b=JbovK0W0akGaKM6FRiTNG1MWsl7zNguZeashvxe8/yVIgZiZt6jCGPksBJE7gHCiz2YDkkoGQYFZT
 PrCdvoQBA==
X-HalOne-ID: 106d44ec-b802-11f1-8b4a-33fc7c51c1c8
Received: from [192.168.31.169] (unknown [41.140.253.121])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 106d44ec-b802-11f1-8b4a-33fc7c51c1c8;
 Thu, 24 Sep 2026 10:24:08 +0000 (UTC)
Message-ID: <40b6ce4f-ac70-4d37-a3b7-c784c9c75471@embetrix.com>
Date: Thu, 24 Sep 2026 11:24:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 mkorpershoek@kernel.org, sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
 <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
 <20260921202435.GC858934@bill-the-cat>
 <8953c3f1-929a-43ca-8708-712a45db9c77@embetrix.com>
 <CAC_iWjKDX2FdzrpW0JxJ-tpj2PksNY0gDyoXz3_T_QRrjaoyRQ@mail.gmail.com>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <CAC_iWjKDX2FdzrpW0JxJ-tpj2PksNY0gDyoXz3_T_QRrjaoyRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Ilias,

On 9/24/26 08:00, Ilias Apalodimas wrote:
> Hi all,
> 
> First of all, Ayoub thanks for doing this. It's on my backlog for a
> number of years :)
> 
> On Wed, 23 Sept 2026 at 22:58, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
>>
>> Hi Tom,
>>
>> On 9/21/26 21:24, Tom Rini wrote:
>>> On Fri, Sep 18, 2026 at 07:42:56PM +0100, Ayoub Zaki wrote:
>>>>
>>>>
>>>> On 9/18/26 18:53, Tom Rini wrote:
>>>>> This is interesting and something that does have to be on our radar. My
>>>>> first question is, should we not just update to a newer mbedtls release
>>>>> and enable their SHA3-{256,384,512} supports, and anything else we need?
>>>>> Then we tell people that need this that they need to move from legacy
>>>>> crypto support to mbedtls (where we get to leverage a wider community
>>>>> for security audit and response and so on). Thanks!
>>>>
>>>> Hi Tom,
>>>> Thanks. I agree with the long-term maintenance benefits. ML-DSA
>>>> requires SHAKE128 and SHAKE256 rather than just fixed-output SHA3.
>>>> The TF-PSA-Crypto ML-DSA integration is marked experimental in the
>>>> Mbed TLS 4.2 documentation.
>>>> For this series I would prefer to retain the Linux kernel-based
>>>> implementation with limited U-Boot adaptations. A migration to
>>>> Mbed TLS could follow as its ML-DSA support matures.
>>>> Would that be acceptable?
>>>
>>> Well, a problem I see is that this is something that needs active
>>> maintenance to stay in sync as we don't want to miss important fixes
>>> here. In theory, we get that with mbedtls (even if we're behind atm...).
>>>
>>
>> Agreed. Importing the Linux implementation means taking responsibility
>> for tracking upstream fixes. I’m willing to maintain this code, track
>> changes to the Linux implementations and bring relevant fixes into
>> U-Boot. I can also add a MAINTAINERS entry to make that responsibility
>> explicit.
>> The goal is to prepare U-Boot for early adoption of post-quantum
>> cryptography in secure boot, particularly FIT image signing and
>> signature verification as some hardware already ships with PQC
>> capabilities.
> 
> There are zero doubts that this is necessary; in fact we are already late.
> 
>> The intention is to switch to Mbed TLS as soon as it provides production
>> ready ML-DSA support and the required SHAKE functionality. That timeline
>> is not clear to me yet so I’d like to prepare U-Boot in the meantime.
>> Would this address your maintenance concern sufficiently to proceed with
>> this approach?
>>
> 
> I can try to find out more about the mbedTLS roadmap if you are still
> interested in going down that path. Arguably most country legislation
> is looking to enforce PQC by 2030 so a month or two won't kill us.
> There's another benefit apart from the 'less maintenance' when using
> the external library path. IIRC, there isn't a single algorithm
> acceptable to all legislative bodies.E.g, CNSA 2.0 does not adopt
> SLH-DSA while most of Europe does. It would be much easier to use a
> library and select the desired implementation (even stateful vs
> stateless) instead of importing and maintaining everything.


Thanks, any clarification you can get on the mbedTLS roadmap and the 
expected timeline for production-ready PQC support would be helpful.
Separately from that U-Boot currently uses mbedTLS 3.6.x and moving to 
newer 4.x involves the split into TF-PSA-Crypto as a separate submodule 
and incompatible API changes. That migration is work to consider 
independently of PQC support.
Let’s revisit the PQC approach once we have more information on the roadmap.


Mit freundlichen Grüßen / Kind regards

-- 
Ayoub Zaki
Embedded Systems Consultant

Vaihinger Straße 2/1
D-71634 Ludwigsburg

Email    : ayoub.zaki@embetrix.com
Homepage : https://embetrix.com
VAT No.  : DE313902634

