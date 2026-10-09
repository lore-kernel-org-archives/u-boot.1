Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C980CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A1B1408B6;
	Fri,  9 Oct 2026 13:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qV-0f4z79nwz; Fri,  9 Oct 2026 13:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A9861408BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791552297;
	b=qhaLyJTlY4N05RgDinPJadF+CP4e6/pNy37gJounearPiGQIu0aOTblUZHBEIovcPxD0
	 qXK0mJtCmts2b0ib9CWox1jmQjxzcaBs3jhqn5AJpZCD7HegrKmloL2tw0eJNFMFoWiH5
	 TY9E+B22Y9XsbM2ysPW+GbvzoIc7luQzkpLli+knM3cHhXVwMHkSc1RqNbBY1E5Lshssi
	 O7bC73Dm4vHEKbhvY5zG309z+1VPjHfdFtTDkThInj2ATuwGDVgaZ0c02Bi+rT070BKAM
	 3wahvfpfUmcUgWeW8JJEpWYQPu16Wb1gV978pEPpwV3InbWjaxGC9/EFX3ozS5OrvIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791552297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZpMwzDEdf2GR+pCWLCKZLH/SR4xMSRtbuNdHZI1aCCA=;
	b=laM5kGww8SP8eVTYm8wCnvVpDvDU80soX/eKN0YCZOMTQfuOzsCUg5s7UvxERgZ5uKHj
	 HjI9ncnQZH6LyEulT6Zi4aeAHr57Fp1gHDp7rsy/IU/hBLzjJ6H2cLwzV06yNcaXK5C8K
	 jUCHzk5mXtzGaO4eFav6H/m/u4qcYroAhggpdhouU32xn2yjGNb0XbA+67aguL0jGi0iH
	 QKfT5gm2F9isiPMBnr9Y5L1RwFmC1XaSEMCsTA7oC2D2qtJ3wuAbXN3zI+qzOqWlKF95j
	 POR0VDNqYx0GLBgaOT9x/SyNYgUAW0FZrAyU3U8T4XthjWPR39dwXzg0i3shbCG4WRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b="vofe6X/f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791552297;
	bh=ZpMwzDEdf2GR+pCWLCKZLH/SR4xMSRtbuNdHZI1aCCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QrJFasHOCIoN/GKjsssq/lHVWKaqhwPdBDMs/jK+Oz41RaWB6vSD/IkppWs4gUbE+
	 /RVAcNtHHNiD8g5ZcEdQBkeTGXs3ExzQjafXLgxV03To+BSFaec3yoWNk6b14GcouY
	 +4W/MYiIkpZ/riOF/5IPF5c6bFr8TxLrzuFu5UdOXxS/gLP+u55uqV4gXpaBfhgxFO
	 /QhaICtkN4mn+t3ru+GzHvtX/ocWNA4l506xaor4BuMJP51z08bXM4M0Ov2dJEMxy4
	 eiQTojXAn+HRyiHA3jrgE7TGFIcA/bCtm61wSu9xHfcHwxPJ8GfO1xeIOktXNLDgIe
	 ukQDdnqjWKk1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9861408BC;
	Fri,  9 Oct 2026 13:24:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A721675
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9857E408BC
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:24:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LL8hlXyR96Wr for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 13:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2FEB408B6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791552293;
 b=QdZw1F4mUvxJWJSZDXfGyc7O9RKWng/IHZB4rzRiMCVEYacZymEONAt2JreGDLhmZMUi
 2c/3lIRm9x9bd3e51NtUmYFZQhF8gXOtZR2CiA+sJNw433OoX++6o29jLFkSSreSbK3Qi
 phNvnnkx5R3O95izCVvV3Wj6wGY6tWPuUlX2Df4FwItJWz1FlcnlC6eOdkgIaA/e9ORPC
 xGolv8lZ9FkkCdh4S5O2XKAx7I7UaKSz0ygbL+8Tj3cCy29Ew6xIqTZrj4i//QYbUHadH
 /qrs1vS5ycftfdy6O5CTyJ/fnAHzc5OfSqqEZzdtOZgt/rgdQs1Wjjb36Xy6UPnHOSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791552293;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ZpMwzDEdf2GR+pCWLCKZLH/SR4xMSRtbuNdHZI1aCCA=;
 b=l466agK4Ep3NWuBup6EN1T37D5UfEcy+aBaP8nSD9O6IBNtkxXx6+acl3YMJ1lf1Fo3X
 5OuFoDHlcEhq1WcDK1Kjc+wXwgoMnckMVuxTR5YovhtKh+/zqU71auPiOL2yRpGz3zAVD
 l9ZXcAI9HIzE1E8OEjmnjs9JPonvjFCU8Lo5wYb6jf3cBPGX2JGdOHoQdxvp8HZGlpNfY
 ixhLOMDgbqWa7ozUNRhawIA2sSHwC5g4+qXo0QgBSQXhUAZwZlX4AaD314kIRg0V0A/vy
 owYWiK7xT5gM5OFti+fUo/0+lQZZgUe7LrPkbcm1szRmrDYmtiQ/UgysciRz/zhkpdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="vofe6X/f"; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c672=ia=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=vofe6X/f
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2FEB408B6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791552291;
 bh=ZpMwzDEdf2GR+pCWLCKZLH/SR4xMSRtbuNdHZI1aCCA=;
 b=vofe6X/f64kPMrUQxqxR+QLQgmsNATgda8fWAuTywSJbn2oDATRJoDLA/6Pco7Vu42nxLVjo3
 uSXN/cl5W4WKpjTYeZ0Z9+9rT64MPErI18t8DmoEIy1PZo2hTbBvIxP7UhCTYfmBFUOepKhpjLh
 m9PZcGfmcrgl8PQhXQpu1L1l69ZoAH51KLXuchoQmCRwAfjhaev5hzDPjFs2PAwFUgMnlFJ7ipt
 aj5Xe2MzPE3vmVJPdgE5vhGqnMbRcL4jlvFWpgb0zRRGbWYhQHjzoYapN3zaJzRvTO1wBoPKitF
 TsOde8PB6YeHJtE8G3Mb3dAnAg/6HAdKH+OM72K4XZ5g==
X-Forward-Email-ID: 6ac8eb239ca6acffe621e830
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b833561f-7513-4def-8d87-1450c99f6251@kwiboo.se>
Date: Fri, 9 Oct 2026 15:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] rockchip: rk3528: Remove unneeded syscon driver
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-8-jonas@kwiboo.se>
 <fb2e83fb-7147-457c-89fa-99b0ae6fb852@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <fb2e83fb-7147-457c-89fa-99b0ae6fb852@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 10/9/2026 12:07 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 12:57 PM, Jonas Karlman wrote:
>> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
>> to get a regmap or use a constant to get the fixed base address.
>>
>> Remove the unneeded RK3528 syscon driver to discourage new uses of
>> syscon_get_regmap_by_driver_data() or syscon_get_first_range().
>>
>> The generic_syscon driver will instead be used for the compatible
>> previously matched by the now removed driver.
>>
> 
> We don't have any device tree node with this compatible, so this is a 
> bit misleading as this syscon device was never created (there are a 
> bunch of other syscons upstream, but none with that compatible).
> 
> Just say that nothing uses this anyway as there's no node with this 
> compatible.

Hehe, good catch, will update message in a v2.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

