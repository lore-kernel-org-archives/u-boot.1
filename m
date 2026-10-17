Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1195CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A44980DE4;
	Sat, 17 Oct 2026 17:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1nD2pccg5T3; Sat, 17 Oct 2026 17:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3E6B80D0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258444;
	b=MX8QHSUnMeQ/E3P9Ce7yg7sh62UNKqq89PJKWXmso68hvUv5S4wMdA8KT08GxFIqAWmp
	 GazU6+PEMR+sJC5EJpVOGhSI7kKHmUyiHFq+svO3rerzLmF0F3mqcKwo1DAoRY8f1h1hJ
	 +ZEZLrRQ8GjL++bJAjnnqjOPdeyCZj2hzayevAOqwCFImmJrFISNilBtQ5vlTNiG7KcPR
	 N2T2uzfzrJ3p6LEkoB7kJrTCAua9Jx63PsTgO+PaETs10ac9iAcXYjKRKb0dbd6vB+auU
	 rsnVQQa+z7ALTmujL2ORxD66UkbqhleZSfaZP6djpoA4P3k9Y/fm77akBCsIQbatU8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=07tZVNxZFHxbiVMj7duUQsJLjKMZDrFdKppm79fBotw=;
	b=ZhrPYufMzEq9Y6DKn1IQoqFEwppiv5s9DTTIoX8RMZroo9I3m+G/0OIFrWVORblaBzoF
	 OlfIGtBGbfYNFQwXWqJyVooMm0Ay4ZbykFG9I8HocGjVPOmUMLHqgDE/mTVhFWzj1m8Kt
	 q5EecqdCLLp6F6q+tMJASrWxdGEWNlspPo7t8CeNEtzrct6hS1Hkl0+su9GMpquqEc6Ur
	 a/e6Hzu6MzTqVETP7YXTpiEb2Ki/YWFJKEFls2RMJM6+iRm2WE1KJTsfOHRBy0hGik0Ba
	 jJCz+Wc0xrQnPCTajZCSRfmhSMfQDdlusK4IbQ1OSjs3xjDukZJtDHvWwF34HOZdqRw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258444;
	bh=07tZVNxZFHxbiVMj7duUQsJLjKMZDrFdKppm79fBotw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGU+tFqOZWd3NmIjG+I8gXeI3Iwere7n6lDFe/cFPwqoCon8hPqOCOD+ZCeKSSHeC
	 MuIixc09XUWq+o16k7B3FAtOb1Nf/7jqop4rNNHTpVnIpkWaThIM7vjG07tt1038g+
	 L1pa4B9CIbSWFsib4oOeOxp9Zw6kTU6YO2pVB9Gdn5EdlsugHfWJ1CcLvXYXiv+kw+
	 bTfoSdkyJaMoyudrlFVOepxTyTPdMfxoH38VZHGKCKgDSGEy8gXNwnb/2XfUA5Ts54
	 nzCuRDwhhiW6EXehxS5ivgDD+VBe31FXJXfAHmofmwm4Lmrr41k2dn+y9T3VxI1Fza
	 eJjMvb0QPpLyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3E6B80D0B;
	Sat, 17 Oct 2026 17:34:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 734552A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6550F40712
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E74OgLrloxcD for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A443540707
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258441;
 b=BUWSvQ36i6qZtJiCTfzerGyzBDLNN9T93V9cWVLbic9ZiMbEZKhok/0UQd2gAu9z0goz
 qS9k0Nh19afbdMjWMeFmjZCoCAQ7Dos/5fPKe5zRKIUD3ra869BpF5fdmbZ2KgBNI6knS
 UtMQvoUkdynJeO5r99BdVCx5Hh8g5X19q796S9egdHnZvD2dr+Mh9Ugsdim4GCyYQaHW7
 hmGBrSC2vKzIMeLbmGFxOZexMphy4uwmgJtEsj3OQ6MtSNvIB3W03hTjoM9bgVuAAKE8N
 dHx7btZRChyeTMFjZ6w6YC1iOZqMNjO6rHxGn4uXGxegQA/WvIzmp9JBbeprqiCzJFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258441;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=07tZVNxZFHxbiVMj7duUQsJLjKMZDrFdKppm79fBotw=;
 b=PqqMVUvxp+V6O8L2e5KZUVDBSigYx0KlXWPOkhzUpj04Qo04KsnUJaciGEs50QYnZchR
 YZR9CeR3lGd6aAciMYBX7ApoDxUZMJONmijSCL0s/vdJVJtWy2yRd+oD/5LUfl9/j3c19
 XYZPgqBCA9+wCR7AdZAs37U9VnfxSAiUC2Zq/QXTF3zRnr3mtdt8B90zgGr4N335WCV0a
 NSbqTTdAT+oNMOdy1G97YoW/Bp2DKq6pB8Y89915VYtSNNKuWt0yGpygdNG6VSf+jjzZN
 Hl80CGAAjXIHyrfrsinivFcFHZQ5n2dvVMQvr7TeKzQcyVCUd8UZ+wfdZzmkH8BRLQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=g8lHZ+2o; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=g8lHZ+2o
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A443540707
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:34:01 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j6TSN4nsBzKpDD;
 Sat, 17 Oct 2026 19:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07tZVNxZFHxbiVMj7duUQsJLjKMZDrFdKppm79fBotw=;
 b=g8lHZ+2oQt/O7U9+kSfP9rOZTw6RDI2t3IuSqxvdbu6//I5O7pBSEbP/m03M/RKyx8EjIT
 uujFmHFwaN4qA2bKCOMwQnDyrov7D3fyTyv/2xUvT+I1O6qTgasKqP5vCtZLjHpVj13Q57
 G7IGZYK/WTaYmyQ6mJC8thMmkhFnjcdHFY3HPvfI/B8EpnHdoOD5ybLLQJ+Z1XoV4SDghv
 SP5Mir6QkGJu0sZAHLUt/VzEBmqVzaWSnye/skU960CkYEo3AMt0F2ug7U77IqTpkDXuCV
 4Lmw5WRTPcPQPgrIwKsEuiShmB0s5GRtmFKZf/CE5enBrxOco1ZNZXizlYmJAA==
Message-ID: <e0e921f1-a451-455a-8781-a989478ed672@mailbox.org>
Date: Sat, 17 Oct 2026 19:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kbuild: Pass -Eno-node_name_not_empty to DTC if
 supported
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?SMOpY3RvciBPcsOzbiBNYXJ0w61uZXo=?= <zumbi@debian.org>,
 Mattia Maldini <mattia512maldini@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vagrant Cascadian <vagrant@debian.org>
References: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
 <87mrsspry0.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87mrsspry0.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 564af2d7aa1729eea90
X-MBO-RS-META: eoonckf9fgjkenarrjobn65irc1khqkj
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

On 10/5/26 8:44 AM, Rasmus Villemoes wrote:
> On Sun, Oct 04 2026, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> 
>> Since DTC 7c78c8542d73 ("Added empty node name check") , U-Boot binman
>> use of placeholder node names such as @fdt-SEQ and @config-SEQ triggers
>> DTC ERROR (node_name_not_empty). Inhibit the error, as these placeholder
>> nodes are updated by binman and replaced by proper nodes, the encoding
>> in DTB is temporary. Since -Eno-node_name_not_empty is only available in
>> DTC 1.8.0 and newer, introduce "dtc-option" make function which is very
>> similar to "cc-option" and other such Kbuild functions, and add the DTC
>> option conditionally.
> 
> Is this the best way to handle this? This also removes the error for
> empty node names that might appear in the "real" part of the dtb, no?

Yes, /foo/@bar becomes valid again, which is not great.

> I'm not really familiar with the binman magic, but is there any reason
> those placeholder nodes cannot be binman@fdt-SEQ and binman@config-SEQ,
> or anything like that? Sure, the binman code would need updating and
> there would be some -u-boot.dtsi files to update, but I'm currently
> counting less than 70 instances, about half in tests, so it would not be
> a lot of churn, and changing it now would mean we avoid having to carry
> around that dtc flag forever.
We have to deal with legacy DTs which already use nodes that are @bar 
without a name, so we can fix this for new DTs, but not for legacy ones.
