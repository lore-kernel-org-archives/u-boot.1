Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4040DCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 23:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEBEF40820;
	Tue, 29 Sep 2026 23:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wp2BtibE5-fn; Tue, 29 Sep 2026 23:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 200394081E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790724414;
	b=Um/3DiTchbXkLHqWhXWtE1fQf/d1VZtRbm4990gXyGJgcKK1AE8xuUbv8R4NxmAjtmFq
	 BniFfC3vLswutFIHxLpVXki8VxlZGMUyOCUpaj0M5JIo//CDKbfdEfFQSzi1LsJz38Lxe
	 C2xz57YGBsZDyra0BDkZyeZ/w0P0cHeYqatgnRr/+fb6a+IkksT6aVqJRGBmBJG6LNZxe
	 u7cMQGCXWgQwuyXE77FB7UC6OWL2CqyjiDzoPQrgZvxyq7+iCQ34PqYpiluJo7VUvO+pf
	 a1B5yrsAAU2KOJ/Pn/8PTCfArTV+u5vbSVy+8QVMlbrabuXDIPREQkS040eU1dtJoYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790724414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zUk9M7/RE115vIwHQXOa+ZFyTSR2ba+zD4tyVU6SPek=;
	b=UCK+UQjD9ee733BFFzvCjvHL5toxCqYae3kzRPsYTsgh8TlcJNeim5EvMQzTVQ9K/50v
	 W4hMz29YUeFk6JfIwDziEBM67HIDjyjOwJdifVJ6H7ibWVymZSIbIcu6adlYtNmXuggLA
	 UJ4iFYHJk9IirM8MFAH1r8YQCdxegprosaSpO8mUqr89kY+o7yHU8fSv58UNVwZljgfoL
	 RGdz2KMVRN0ci7ezA4BhZJ1Ga71Sf1AMgYpUC+8Ll9ku44KZpsVUSkAXKjCu0p9HgT+df
	 0qnP2W8SS8wFXxKg7bTKBHDxew4GnqOQpXesB71xNhWeTa52/M5HpLZWUoYl5RO+qTw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790724414;
	bh=zUk9M7/RE115vIwHQXOa+ZFyTSR2ba+zD4tyVU6SPek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t3QkmmoNFYEgDKL/fK3xv1tBTHcquYRY+cVInGY7TWa0xocHd7T+naS/jhfNNnBMd
	 hQfsL636LM7EUAzzOtxm1giMSyIgRJU5AlbwM6Vcv5rKZgVOshEJ0Bp84tfbKHFPsm
	 nGrmb0TQCqsrEN1lZdyVMwdASNhPMgTaocHoUf5Dnf6vi3FGY+Q3S3rwcd02mYMxtx
	 CTTLkiogBzGKYn4wzRUL5onI0thLkaG5vbH7wjx7CKEN4/XgTKOleGq7EzlZPB7eod
	 NAjmS+ai6ItL8wAnoDbo0F6VYkYVbFZE6eXd+Q5Iy6tPh9Q/ZyP5NJlDZ6fXkUQN8C
	 9CtsgJpt1/tQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 200394081E;
	Tue, 29 Sep 2026 23:26:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E74B824E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8F204034E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sm1gnyh96i0y for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 23:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E7B7E400AE
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790724412;
 b=pwIAobqmXUqT3LhtGB/0a0xGXpEptrMDZ6FmLk7Auqgb2fzCHYAqJLyTGfKHBOPegRBA
 00vQtEdbL/diTmVdnzGRiqeeW3UyscAD4L+xpC9swVIvYBQr2fJliMfS+cGEgpDJx05y3
 LhhPvpnWdKaRxQ1q8IG7+h/TZn6pLwwm8+AcwOmXnxiz7gH8y1JOWrcKeAEmZxvgWpbwW
 EAFeA/0e8a/TWsEcCRojUseSbYTwHdoI72ECXKxoSBFOTbDIGSYTatCcqynyawWrzAP3j
 dYBCj7vre1JRxecy6lOw9bQnk7ryOGk0QOp8+DmjvoM9i5AwGl71zjlmNac04gLvJXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790724412;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=zUk9M7/RE115vIwHQXOa+ZFyTSR2ba+zD4tyVU6SPek=;
 b=piP37W+5zzXZ2jafWVk3YHfwNqw3H0kymq5ZmFoVKrBqtULgJm74LmVdqw1cx09QhHCs
 1wKyMBZy6XClJ7OMnCi1woO+ALoQ3X+eWvHD0YOcolgi18ezIy0/qo1XpUOXEXLNOhIZ2
 6wvZLUlcZqLtqpdNZfAfYnl/Pku4Ytv8Ed7aXiZwR0nrx+zNAWgXhmGN/WixWJ+Ih1nLp
 qy1Zx1Db3yqKnHO/rzQf0Sn/tHGUkm2LdXoCpIy8IEEhwV/qfxYuvA2pSVfvqvCHL+ayG
 lCZIKFSsVDIEDE07sPrhIbPRz+MWFXz8dRsnG2kUWrLJZXVz0QZNa+KaVQmhp7XqGcw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Yho5i6SP; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Yho5i6SP
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7B7E400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:26:51 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hvZ7r1Dr2zMlFw;
 Wed, 30 Sep 2026 01:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790724408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUk9M7/RE115vIwHQXOa+ZFyTSR2ba+zD4tyVU6SPek=;
 b=Yho5i6SPGVIVQH0FzScx/Lr2rjx0IPZhHaqtdmT1BalXN7O1dYf3P/zqTSZs3bJlsuwpvI
 Ruq4ZVKjlstn7amdntzOItLN6SbJ2T1v8aLkomNAfE4BhyL4T79gmUkB6xPU/aRdJKsBaa
 caXt/yyaTVUu4oWPtYyWjMTVpurGwMJd9uZ25qXV3KCACgB1beaNxJzFcS4m6etHlNQMg+
 6zpjpdb1n/nkWaiyGVsGgTruBsMc+7WckD32Un75IUxjxThiq4VyQgXnv9j9WSctdoFq1h
 aZiG+RlN6xcDsgu6mxzLPiyfstjWijFU+3d6IpGznp0xAveE1sUR6lI1syZfYw==
Message-ID: <71a56a26-67a6-43eb-a90c-71231ec2cc0a@mailbox.org>
Date: Wed, 30 Sep 2026 01:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
 <20260929225108.GD858934@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260929225108.GD858934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: y86wwwezc4uq97n1yk3umzw1icrg1bbh
X-MBO-RS-ID: 0753aefe481602bb06a
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

On 9/30/26 12:51 AM, Tom Rini wrote:
> On Tue, Sep 29, 2026 at 07:31:59PM +0200, Marek Vasut wrote:
> 
>> Add empty string Kconfig option, which depends on CMD_CONFIG and lets
>> user embed a short piece of text into the U-Boot config, which is then
>> printed by the "config" command as part of the embedded .config.
>>
>> This can be used for example to embed OE /etc/os-release into the U-Boot
>> binary, which can then be used to identify the exact OE build from which
>> the U-Boot build was built from:
>>
>> Insert content of buildinfo:
>> "
>> $ sed 's@$@\\n@' /etc/buildinfo | tr -d "\n" | \
>>    sed 's@.*@CONFIG_CMD_CONFIG_EXTRA_TEXT="&"\n@' >> .config
>> "
>>
>> Print the configuration option:
>> "
>> => config CONFIG_CMD_CONFIG_EXTRA_TEXT=
>> "
>>
>> The output is a one-liner print of the embedded string, it is possible
>> to interpret the result and the embedded control characters using e.g.
>> echo:
>>
>> "
>> $ echo -e "-----------------------\nBuild Configuration:  |\n...\n"
>> -----------------------
>> Build Configuration:  |
>> ...
>> "
>>
>> Please note that this does increase the U-Boot binary size, and
>> therefore use with caution.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.u-boot-project.org
>> ---
>>   cmd/Kconfig | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index ff90a87024c..0d8b152f12c 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -170,6 +170,17 @@ config CMD_CONFIG
>>   	  command.  This provides information of which options are enabled on
>>   	  the running U-Boot.
>>   
>> +config CMD_CONFIG_EXTRA_TEXT
>> +	string "Additional text embedded in .config variable"
>> +	depends on CMD_CONFIG
>> +	default ""
>> +	help
>> +	  This option can include additional text embedded in U-Boot .config,
>> +	  which is printed as part of the .config by the "config" command.
>> +	  This is useful for example for embedding build information into
>> +	  the U-Boot binary, e.g. content of OE /etc/buildinfo, but please
>> +	  do keep in mind that this does also increase the U-Boot binary size.
>> +
>>   config CMD_CONSOLE
>>   	bool "coninfo"
>>   	default y
> 
> Is this just intended as a do-not-apply?

No, but if there is a better way to bake /etc/buildinfo into U-Boot 
binary and then print it, I am open to suggestions. I am looking for 
some way to finally replace .scmversion with something more flexible.

> Otherwise, it needs a gating
> option as well.
What kind of gating option ? This is gated by CMD_CONFIG already.
