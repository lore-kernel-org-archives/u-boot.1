Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EA8C9831E
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 05:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 401D440AAD;
	Sat, 26 Sep 2026 05:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqo2TDhJU1_0; Sat, 26 Sep 2026 05:19:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7CD9240B02
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790399985;
	b=MZiyRlTWVG9W2CiVX/mKZDk2T8DshZ1DHm3VD+9nQ62UwtZjC9IKcPJfzacHG7/UXefs
	 EEzw2SdhhXfLR4PhCbRjF4FB66Q848Eq0O/JtFasBTgOxy/Ej8oahdWMv626llvo/o1Mf
	 xflxYHHYbQyFF7oGOBpZvsDfgEwgJyDJYu86mPZSUK0DW9YaP+mo/xoKuWp9g3MnWL5eU
	 Nqp0Lt3xudEDSM69RWP52x09Ub4U6ehsE8cofg2Swd5ayZ19XbUHMDtdG920ISNBaDRIZ
	 mwpHOD8049spW3RerOFb2Dlt1A9y0x7qyqUzDVEjlBkJklcsuMzH3g0ASZ7jkTqMeTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790399985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=owHI/lE6ANn84wto/6Pw/qa5fsjq5SaaGGfbiME1b3w=;
	b=AaMdzeSAUM10iHPflZx90rwgodPqOzy0fdWZ1lE6ESk6++ZcoFJOpNmFjJbEa8vfdiRv
	 lc+eYvuQR9SNomwZ1dLeBOBHuO69IX3VTlYs5osIRpXehChv++IYVfBCBNjkEw8DI1cUB
	 SotgtpHWKCQDrARjI05/MFz3hlF+InAZmADkWmTfv0Ka4szVDwA5Cf/c+pGSUyod10ou6
	 z4ZIDAlqggiULL4LyIT5w7csxPJO6CXLKqY7q4KRO0emd4+Nv1vwSandQjqxIkWOjxSSx
	 TVXp4SQL2FgFqIi7rXAlJujNizD6o/BNA8NPJq87Kr6cjXeJFxdS7Q+2XOiNj8fFXDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790399985;
	bh=owHI/lE6ANn84wto/6Pw/qa5fsjq5SaaGGfbiME1b3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cd+jEm60CcGdQTaZW3dL6vVsOxSfAuhsVy34/Grw3LR+X33W/0PTtgTk0rjWX8smQ
	 w9DZlBRum2xfzzot+vFxONfDiDTSTMVEell/la7cJMe+3rEarYDA5SUXAteVEQ88+3
	 CZkd7AeTtXkyDf6q8RY/kYO9cLMRzFs0bXC0ExEpQU84OZqOquKoSD0cCi6iUp+HwT
	 cIxBU3kR9ZN59AUQUkxlKpTFU5JMi3+9b/Q5kkIGvBozPrLwH/p7JuY0NDMjUlhurg
	 gqxf4cgrsHbzgA4uz2iw5vVkzxBI0Q0kLE+k+zGtGALhM/bzhIoRAtcTBoSWYYoRuD
	 UV1tV3eioRKZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CD9240B02;
	Sat, 26 Sep 2026 05:19:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3321622B
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 05:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18CF2400D5
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 05:19:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxjuEeBty001 for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 05:19:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C139F40062
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790399983;
 b=IxpiHNyaGTCEqtFzRenyowlzA/xAKovY0yYzLmbS0e+nDcgSQoscqhGV2I2HIcu4DdTp
 lv32CI9VRquDLA1sJhsgPX0rHFDfKMqg+i1YQNkCz2xnHIhIddqxE+q0knLDUaklKTDUd
 2jGjclzAc7DVtaubLQqVDqydWWcD2C0hgwUTeigJZxxP4c9QtY+VeIybNWb+byQLtWoxj
 2hAkP07LTaXhBoJ2sp/BeE71650AGD1TXtyKrOUQjJWlEUv1L7hGD7ojvwzGUVnC1XaB5
 EhL8lZpan5Q0aRd6raxquNIWFalo55nHc/GEmLZCqyN99Z8ypvYbpdH7Y0VMlICG4Vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790399983;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=owHI/lE6ANn84wto/6Pw/qa5fsjq5SaaGGfbiME1b3w=;
 b=B/EH68sSJs9uSVKTT8DC0frbvK2JVBsGpuS+KHwh5yMXXVuDJ4yN2FAsPg2lo7LQV9Au
 /w842+z9mJwGh2EXIBOU27PmNj+A3IE9GNItiD1BQo9sPOjWf9tdDfk6wevLMrDNmjkXw
 JYPmcYDl8wPsx58/5XDR5nU6b7Q+9yWvRkTdCoOVjKFdQxLuf2ftuL5wjo0ywlJeZWBQQ
 bq1ORrfr1jhl/FdZtzHVtYCDMEHwt/nz2i0xRS9EWcCQ6c2/lyECLR+qjbc+4wL5QrjNw
 VkYjUusVLPVL1jhY/z/6P5hB7zV9R0GiRoY5fG2ohaRvHj4bX/6PoT3jsqxbwAwOeIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=g8GdMLwy; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=g8GdMLwy
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C139F40062
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 05:19:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 11E29105F00; Sat, 26 Sep 2026 07:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790399974;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=owHI/lE6ANn84wto/6Pw/qa5fsjq5SaaGGfbiME1b3w=;
 b=g8GdMLwyDFo0Ou+jXx5wFq8UPaijQv9bbCAR7aATmz7a+xD1q3dGkMCpUVhrCinKdSQ2iF
 7kZwTUIXDl4cpI3VOj+wlgnIJHuVYWbxMb/fetP31h8aZzp0Rd/cSwuJShgYfVxsLbjv5P
 WFNyOIPxM6QRIG9kAwkM7LllUQXJnU6HnOWlo3Qk1zqbiSehTIP2sP/+/COnQUFE95i6Pe
 bPSjfdA8QlZYltEQ+fvysKxr9q5SvU0gTIzwuVDmKiW6IAh/8YovbL2RMGn/p9Bi/xx63D
 nmVy5g38kIpPnIe7UWmbZFaOIitYIR8JoSCYUhTYKK/erjRd55shxgW7W72aRg==
Message-ID: <239c7922-49c4-4ca6-b83e-d02b0527d8c4@nabladev.com>
Date: Fri, 25 Sep 2026 15:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Synchronously tear interface
 down
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260903020231.1278473-1-marex@nabladev.com>
 <87o6e9tpm4.fsf@kernel.org>
 <7c93c6c5-2d94-46d9-a73e-400837be370a@nabladev.com>
 <xhkdb33uxsq1u.fsf@mkorpers-koolstof.csb>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <xhkdb33uxsq1u.fsf@mkorpers-koolstof.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 9/25/26 10:17 AM, Mattijs Korpershoek wrote:

Hello Mattijs,

> On Thu, Sep 24, 2026 at 23:14, Marek Vasut <marex@nabladev.com> wrote:
> 
>> On 9/7/26 10:47 AM, Mattijs Korpershoek wrote:
>>
>> Hello Mattijs,
>>
>>> Thank you for the patch.
>>>
>>> On Thu, Sep 03, 2026 at 04:02, Marek Vasut <marex@nabladev.com> wrote:
>>>
>>>> After fsg_unbind() is called on UMS teardown, the fsg_main_thread()
>>>> which also invokes handle_exception() is unlikely to run afterward.
>>>> Therefore, any exceptions raised in fsg_unbind(), and also exceptions
>>>> raised in fsg_common_release() which is called from both fsg_unbind()
>>>> and fsg_common_init() fail path, will remain unhandled.
>>>>
>>>> This leads to a problem where FSG_STATE_TERMINATED/EXIT handling is
>>>> not performed on UMS exit and the do_set_interface(..., NULL) which
>>>> shuts down endpoints is also not performed, leaving the endpoints
>>>> enabled.
>>>>
>>>> The CI UDC driver does check for repeated enablement of endpoints and
>>>> returns -EBUSY if an endpoint is enabled repeatedly. That prevents
>>>> UMS from being started after it was exited once already. That is,
>>>> running "ums 0 mmc 0 ; ums 0 mmc 0" on U-Boot command line will lead
>>>> to one successful and one failed UMS session. The later session ends
>>>> up triggering fsg_is_set() assertion in fsg_setup() and triggers a
>>>> panic().
>>>>
>>>> Fix this by synchronously invoking the do_set_interface() from both
>>>> fsg_unbind() and fsg_common_release(). That makes the unbind behave
>>>> as intended, as if the fsg_main_thread() ran after fsg_unbind() and
>>>> handled the outstanding raised exceptions.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>>>
>>> The change looks fine to me. I hard a hard time understanding why there
>>> was not an equivalent fix in Linux.
>>> I think it's because we have cyclic in U-Boot and real threading in the
>>> kernel.
>>>
>>> In any case:
>>>
>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Maybe this could be added into 2026.10 release ?
> 
> I'm sorry, this completely dissapeared from my radar (It was not
> assigned to me on patchwork).

No worries, thank you !
