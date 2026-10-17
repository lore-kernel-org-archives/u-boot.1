Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07DFCCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 987CB6071D;
	Sat, 17 Oct 2026 17:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3yHHP60Oivc8; Sat, 17 Oct 2026 17:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9AD3D60689
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258402;
	b=IN7++JSM6aBVxOjRs1GvJGOFv3dZJSwlv7UB7YR+AAYcWw//Nptbe9xfV+Lk1bMvzwxa
	 l1hZmCEJnFWd7flyiXSj8EjZGlMiyoExh9L+11OvSYxyukaBflFX20GTkbZtbJxdD3GN2
	 ikWIm5+OsiGEgnsHt+OdFleEzq++AS5YeoA7leUfPRE8oTblUouSlaZLQMlGRwtCgWpR3
	 GGJ13ilHU+1yXa8LozUG30k+q2Q4jN47RMdeJs65/7D7FPJGDJq9RkHCHLPYZotdsa0Pm
	 brTddiTulElD+rvGA2vSX3IfE2o4cg5ZV2i6B/LUzAfC/QAQyeQaLozK2MuwwCI0ncg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ojl1HBnRoBS+XpYmP3MG0ynWop7kL7l5z4DdTCS0KW4=;
	b=Zfk83I0CSStsBRBr8BQyDCqDn+UMnGtw74EmJ1qRRBRQ2ZzsUeaSbJM9IpI1877dIrzO
	 NGreiF81qrdaxn7+Bn63qIk26psyR42PiimmhGGP9WnbpPBi/kEDbSi98+oIcBVZcuYnU
	 LVTlSY6GGg/id2dZ9MF0LiW0NegkiuG0Xdz85KbF/jfzxKjkUSZk1/kDAUxF4He9EG7W0
	 wwvngDnPP4S2lntlAXg4/aqHcCGuvmjPSIYWTbsxvGVBtog1babgpW0l5QW9/mlRaaRw6
	 I95KOWAW6zENuiDFrEhzLakvAl6MGVkH5Nnoanbby64cxXGsmIqC/8A7OJmiM2AMNdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258402;
	bh=Ojl1HBnRoBS+XpYmP3MG0ynWop7kL7l5z4DdTCS0KW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yTjKzOg6kT/0TLCHk1/Cz3608zfY7IHg0UPncmYaoIZcZ67hwwETDjAiPjWvpjmKb
	 bDVWLz4rFRYmVoLgZUFrsBILBV/tzoMnJO7B/o4QNE78HaueJOAcsvHDO49lb2BwGc
	 jSO/OV8+RlQJISKeK8kCDmXWLSCASpR60MuVRvYQWvuDQxJH16d8lmbmGHyxnyu+gu
	 dwCU8SO1D1r4tRSVDu15dSIHNUHdA6pm1OSRbujGpIJ9H0Mc3SAIRFYpl+SPVzMYzx
	 k5TOmkABUZqjU/tyKIDzVdNBgd+Fv0ka0ZG4yD0IPA+KQAtgtnb2syUT1XlABH6abF
	 Ropj66OH0dO4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AD3D60689;
	Sat, 17 Oct 2026 17:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5745465
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7A4E4004D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thijPCqGHMak for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E181E400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258398;
 b=naH7p86jX8S9O27U7fv5TCrBMxmQdEsoil1P4kJQUXx0R/2/znvUI3TdIp6VtKY0vO35
 30eINH+eE4DwKRwQk5BhpSdulFE9o8ZA3EUXFfb2FBSF9fTjiD3oV1JxMV4nYFaD6l+rB
 5ThjPHRPGWRM8X70lHq9g5uN84PyaGXsNH3QYpl4cPV2OR3PiKKAwM6utq7hWayvlrJAH
 tXtZzpU179zMdn5DCaFPcop8iJqW92czsD2V2CJg2wMAPXiv0+BT17gkk02+EZU4VuUl0
 4Y/25+XnHcxTQOxOXIRWKhxumNrOFGov0v2J88eICrtSt8St0V6l/aBItBFMFW16RWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258398;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=Ojl1HBnRoBS+XpYmP3MG0ynWop7kL7l5z4DdTCS0KW4=;
 b=QkI34vx5bMnm6KcYZqVQI2Dcf/q7p+GHueAAzYSdIarh4iQjSPvvuyO2SQICs/8BIsKs
 mxkvluWmBwjwPc71GCOd//60cH/bCLorPdoNyE4u4F5WA4JmIupHy9NNppi9zB1Vgy8B+
 XD90AXWwZTXBj4I+54ZFpdj8JDJm/0Nr3ZGQosVOoWL7miScqVPhWkfL0JAb9cJr3C8DN
 LFeocOHOM/rUJpAb3H/f9ch5bp/3c2ubG2wHuKDNPRvB2PB4I75/sKGD+n25QiKy10FrM
 UzUdCRlGMd/SjpsykWXx0T94dY3c3owLiRE4PYRlV1WVxQNSlaWMTRRvGY3keyL7K1w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=xFsCb0F8; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=xFsCb0F8
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E181E400AE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:17 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j6TRX6wbNzMlJf;
 Sat, 17 Oct 2026 19:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ojl1HBnRoBS+XpYmP3MG0ynWop7kL7l5z4DdTCS0KW4=;
 b=xFsCb0F8JNJQC7bCX4da5gaVmNPRbTZ0YU4KqCc2X6poxGgWiD8UR8Mab+xgHXiZZNQeRP
 whMsUEP1A8v8zLGRT4na2ShvF0oAh59yPcw+KlKOiXd1y3blyGY9UT6KvzmdY3ZLzi8mlh
 ZOxwMJzc+w7e8hhGhKUt+yovsomJjLHN6Hd0SLwNowLLVD0V4B+Pn7pDzxFV9yNmBGYPla
 pwkH+YjBcDMkySX1fD4OOGlDs0cab+K1lx4fUI2x4LypgYY719dXnqbngzUkDtDRhsO4bd
 jmYaOuWd3Tcoplg7pYWZbvBQKzl6zfi5jOEAgItbMzw0/LXj9dmUSMjVhrJT+Q==
Message-ID: <ce5941b1-752d-4e5d-b2d9-a7b919a24a33@mailbox.org>
Date: Sat, 17 Oct 2026 14:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci-mvebu: use dev_err() instead of printf()
To: Stefan Roese <stefan.roese@mailbox.org>, Bruno Banelli <bbanelli@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20260823104310.118587-1-bbanelli@gmail.com>
 <2192bc27-809d-404e-b503-0faa27016991@mailbox.org>
 <20261005074440.589817-2-stefan.roese@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261005074440.589817-2-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pjgpwhj51cqkd77uxesq6nc3b6qsygxk
X-MBO-RS-ID: d1d185a4984be3f397c
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

On 10/5/26 9:44 AM, Stefan Roese wrote:
> On 23.08.26 13:01, Marek Vasut wrote:
> 
> [...]
> 
>> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
> 
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
Applied to usb/main, thanks !
