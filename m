Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0748DCA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 10:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D43810D9;
	Fri,  9 Oct 2026 10:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ztwUiF4yLi7u; Fri,  9 Oct 2026 10:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A4B0810BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791541654;
	b=shcoAMJoJ5fxGgzvxtaJw/PHUCVM/fO1ZDoCCEcVhRtvBi2cw2mR+0BccO4aIFn3tAWm
	 1rvxjfbnAfxhUHo4yIMGwQ9t79XDqV93PcUM74QaMwpnORFtNyzTSFYd0IwqsEiLL+Z25
	 +TUUvNT8U4D6std10WrHabZo58PbrZKJE46da9Qth3Kgg+JASQB1vOxG+Mgs5ofZGngiO
	 a32n2WR+yMRseuTolTcL3M5sUYGIq+wlsABnBUXwV604lBsqm8fkt0AeIkcZSg5CLjQls
	 B6M6BO+p5KVCEj9yHDsSiWXCguuQRagQOjGqY3S3UV595r4kkIc3m6W+XrAnUvGIe2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791541654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FAy3VEHbWJU4X8pazHrrEsMFpdeL5zpI4MnKlLEQCI0=;
	b=J4ZhpA9trs0FNKNk6ldcpTpfIlN3LDFcFVUewNlwVOHe4FmVk7P1CAqXCLGfGBlQhRaP
	 MnUebK+sug18l5NHotGJLZ/UH3qXcdxv5NkT6f2iW4U+7notTaZq4GFOkJX5638EIAXgn
	 DQvcnZ2+Q0S1fMg8jwYOTJdE4AYoiJ7WL4i9S6H/fu+9NFutMyJX9Q0a/aEp3D15F6ZBS
	 KC4AIAZPejdeLjBykK7AiKoRWX5iMPNwvxERZa2LxBC47hs0Swk/HaldedBc1pxmhP7bJ
	 MUs3EE8KKESsXJcXgppj1kop+IOVCNtVuELtBDcrqRZ+ws76kt9cYIgpFDJjNs2Q6FA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791541654;
	bh=FAy3VEHbWJU4X8pazHrrEsMFpdeL5zpI4MnKlLEQCI0=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/pkplz0MCeRnF0PuAMZmydbAuBVPfnkPQEOTr4DgzAgN3gNqxDQWdsOSddXvvpdB
	 v9Equ60dIV2m9ZcXxhpe42P1GeFs9kmbFEf7qeBo8Rwuy16SkK/OffwOHo0Gih0O7y
	 S6evTlJfGM7c7jBPMcj6Rezk5L7YeTiK3p4Z28Gyn8T0kDhDtuid0Mil6gzYaD+2X7
	 +qhBqQDjVa+xEcNAHE56dOf3yOZxz6pCEU0TcS5H6Bz9Y99s7yfahsAi/z92LJDWFH
	 noz8kb3GHCQcTM31xoawHXhabdqxU4/9S9tE5swlZYAoWKMQChwzhdPFzRV+CnlLLr
	 Jpw70FoWnIxvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A4B0810BB;
	Fri,  9 Oct 2026 10:27:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52B2E422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3864460638
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_cWgfTFRNVO for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 10:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F2006061A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791541651;
 b=JLfJZAnTrkWeCZ7hV5rCZUVEkxUZU2wFZ2stfE0ETOp0oN9eiWu83vplKO9o0ry95rb3
 CLBJY10maXRrhrqsgpHsP7MVRB6MT2CPJSYp5dTQYGbg7EVURrPHLVybqRMsznzosGDPX
 zYn8XHPBNL+VmBshRLH/n62HXAKFfrHBf+SD1BVM/Fzr2OVYArnurg7C6x90lpIaElqSz
 cpBsgDqjeBojJmMRii5HUg6F2SJqu/Mc/sRAGHjTJXidHKUljwyty0/Le4udTHvYY5h5P
 Rz1bOHWjJlnTFtqE6I+bP1Wue2jMANkjqx+jMA71rOVTFDXHdPjUVZGJ5ZeaKJljUrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791541651;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=FAy3VEHbWJU4X8pazHrrEsMFpdeL5zpI4MnKlLEQCI0=;
 b=bx1P1nkhdMcMVV/A9O1U5GvxqLEXYQ1h998TkMg76TL7u3+OFyxku4a2YMpOEwjMWHUI
 yussxQxA6soVDcPUdDpHG8raphDEl1dGRfATpQi9VG1nlSTzv3TGLO7f6vQlF/7SXbUmD
 laUZLppu5YtB+8t+oHn1dsZxuXjlqxkqskY8XAotSnJzzaWYxhRmnmaOkjYF9kAaYjCcc
 +DWzoycG+5A3G7yNp7dpCT5B9RjxmvWgDwavDo/RK7ir8RWmVwdKka4BfWwy2XTozMMry
 0OKPQRSwvmhAfYw2wKVmtJvPZnzsaWIIY6v9265NMld4H5Aadm0eN2eZTowRCps3lYA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Ks66Br+Q; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Ks66Br+Q
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F2006061A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:27:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 282F4105BB9; Fri, 09 Oct 2026 12:27:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791541644;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=FAy3VEHbWJU4X8pazHrrEsMFpdeL5zpI4MnKlLEQCI0=;
 b=Ks66Br+QIrobOClpmFzLZQaxhey2aPzVLQYPF1cQoplVE5pDtGyXCWWSWSJg9qfW6VetlN
 BehtrWo5osISYse6z5oU0ftJo9Ci0OyXwVgNB/dnF91AVXML9D65EX874/uqkwt4pS+h2C
 bCoctoDRfDXprFCToi3v/a3DnccZKFZeWGJeuDXWugqUM+E7nuBpRNHIA2Jzh9lRlLXyWb
 QTRBSWHc8m+Vhy2OHpILD+ydViK2KXCahWJuL0IAelplE6cCazAjQxwWjgAcuIs2v533OT
 CT+nQGxFEZJ3j9r8WryDi2zc17bQKJyi4XgElNeeH1IbZoU4Tr6PiFC+oSjUNQ==
Message-ID: <adb0c54f-e6a4-d6fe-2d44-1cf489f608b7@nabladev.com>
Date: Fri, 9 Oct 2026 12:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
References: <20260914091932.1194199-1-JJLIU0@nuvoton.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: npcm: Add deblock callback for bus recovery
In-Reply-To: <20260914091932.1194199-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Jim,

On 14.09.26 11:19, Jim Liu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
> 
> Add deblock callback to perform I2C bus recovery through the reset
> command. The recovery always resets the controller status, even if
> the bus is not stuck.
> 
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>   drivers/i2c/npcm_i2c.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

Applied to u-boot-i2c

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
