Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA99C79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:08:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E51B80D64;
	Wed,  9 Sep 2026 09:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zG88TZ_7qvKN; Wed,  9 Sep 2026 09:08:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C126C80C7E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788944932;
	b=Z2zPbxrZzCUl0dLfx0eRHjF6Mo266fzX6xqKaCjW6r7sIMNZk5g7j12NvrZnIvOV/rnI
	 Ub5yGNPr6iL8x78uln5RhSpBzKYuiOo73BB9z0yra3BllJ3Nh/7+k+nEPSCnJQH3Vwd89
	 ivFIdSDs4rQF2QnQKJZ2y/3vXVZ+5O6vxvzsQOZFW5tzbnCPqNS4rJecJmRXg4EglAhvA
	 i1YoFYis6Z9Q6p87iOMM98g8wFr8pYM57o2GHty2VkXW4d8sORqGSNNLk9eQFwJBepU4I
	 FHpQ4UCxjheiMSVOWlt1UhNu0vWOEnC1PIrg891QbCYxXAR54xcgDU4Pq/IOmb6eDOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788944932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=swq5odIlW6hMlX9GM734O/cPZ/0Fk7kjEMEYAiFt9Xo=;
	b=J7jtP+x/C+gqQxBEEmuDthF9DoZDAaxQCZp8fuVusSssAPtSgY7nghA/YsVa2+DVdFCX
	 pQ1HyAzM9aJfv0a2gdd0GSsF/I+mqYhyKfhMTFxVXIKi3Zx0Ruv4Qv7w9OAGWHfRpTTZ8
	 49FrPQO7UOyJnD78xeH9X3+c2UPMMVfrZuUZp9dSuQ31Zv9wrhZKb5Z5que+lrOrNzPc6
	 QX7RMB3rKTlizdYLS5lAx3DmKvqx6zrVBW+XH6vxXksKZdRh+o1aGVhbcYc7nXzfFLGCv
	 WEt7zyU2XGmrnuXyTrXZLThrsALNNsfV0e2IteYDRpyGFjHcRnZMrjV0cvxZD8PJpSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788944932;
	bh=swq5odIlW6hMlX9GM734O/cPZ/0Fk7kjEMEYAiFt9Xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IQNo5KEmVnqo4jFJZ/s+euPSWYozrPxCuXqD2bkuizEEdyOQutb4WozZXMCKuI/CB
	 D2DutkkviTJaoTDudMaYW3nx8ZsWnDmP23nDkqtdPtvurKgmQW+CENTvnm7qARI5Sk
	 CT3AcyLqSNr+tCSIedia7WzG/bg6Sr5NZh88bV6KnpdMelbRHZOwA50QFKpXBgrMti
	 jiQ9NvEFDOKbJh8xcdRl0DQq+RVhHC3e8+c2HQuaDb7FrFLdlc1S9H6OaQLpKr55mE
	 ftb0W4fBEoynAkoRRBxoFd58SLECNmXxZ54hrar9JW6vSyGmkxO+OKBNOzZAqR/lLV
	 Ln6stWt8dLsxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C126C80C7E;
	Wed,  9 Sep 2026 09:08:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B27A42D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3E3E406D0
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKvAVgwb7lKL for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 22C32406C3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944931;
 b=PysUZc17HL0QvJbkYODuyarzc9T9vvZ4U0hbtMSslpPQdVAUNcNi50v40lslMhVbm8Cz
 e0OmUvxfGCtWuO4ahhUNgqtjLa3PTU/8K4DAyGwphsIWPAAgxHyVok+n3XmrGW6bcu3sL
 l//C6qlC6/RkSNaZ+NnBjehVmHC8lbx3j58PNzwjlmXCPZ29iXYnlRaJSlITIsOXI/sqN
 TFHi8cHd8BOZXTxFLVjlg9bh63hrybomIoJ1biGBNc8G0VNtaVgCy/yTE3LTW0E4xSxRV
 QahnhpUyOCcPv4zgpwCQ+lxCydAO0sIz9gIzAPfWBLL2ZkPzCF7vTTjooxRKusTf7fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944931;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=swq5odIlW6hMlX9GM734O/cPZ/0Fk7kjEMEYAiFt9Xo=;
 b=I9Tbr+2TzUJ+BuwrqUYC2yoRVIL9UHYQnZdadZstawT3kL41yEPFEZxVbVlKIy75KHlr
 IoF4MzRRIipV9RSs2D9p7aDPd+kuLaa58jVcexuiud6TXH+zUEN2kknfaTkTOLz7kN6W2
 yFrXhx/MQvWX22UKSDjZX6yVCSdQ8t+WKK9Cx5IOmoJasOuAHIx3ipzBqIadPFVEsg3Lg
 EiP0betuXn4KEqeYnoZSwBdPicf+4zYk5PHhAFZcoFq++RN6IxcCAkqWmpznBzcVSEalG
 /4D4cwHTJnetUX8zHDgcMIZsZLURyyCVooHQX0o0+S/2B6GPB0h6+MmAeVKAKYekdMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="kjP/Ti0G"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kjP/Ti0G
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22C32406C3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:08:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6769343CE4;
 Wed,  9 Sep 2026 09:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5A81F00A3A;
 Wed,  9 Sep 2026 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788944930;
 bh=swq5odIlW6hMlX9GM734O/cPZ/0Fk7kjEMEYAiFt9Xo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=kjP/Ti0G/z82tcr1p7YlHjyFalvPLFWZwDRH7OllGk+ujoUhv/uY5VjU8odxMow1G
 EpEdB63jfeCBj/B+S6p/NdvJaaI/0JGZ7SfDa0yZkFsxyyzkwTTNw63Jz+6yLZ3KLe
 4A58zRBJ/PlBnP1h+ZPwITFv9j+Q1fwl+yJ/gj/wMmcKXszhV7lovXQKFT86M4KejE
 rkDYy3rL0ntOkMezRTrq4zvZQK65G8usk7IMflAGreGzsfvp4J1c7+dgSku4LgAcTX
 WEpIqzqicbZpEG+C3xMPkOzYgSCgKUnB5GJVx/M8VD6JgyHldsTGX7yELzsB3HC9aa
 Jz4YMTIMB4dIg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, =?utf-8?Q?=C5=81ukasz?= Majewski
 <lukma@nabladev.com>, Dan Tran <Dan.Tran1@synopsys.com>
Subject: Re: [PATCH v3 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
In-Reply-To: <f5107afa-7202-4116-b02d-29accb4d7617@mailbox.org>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <0103125b2e7e1a942202eea2c7222ab00d6857ff.1788488867.git.Thinh.Nguyen@synopsys.com>
 <8d741110-05eb-4861-94b9-19ef27c9ce2b@mailbox.org> <aqC8hnAHrQ8Cv3iR@vbox>
 <f5107afa-7202-4116-b02d-29accb4d7617@mailbox.org>
Date: Wed, 09 Sep 2026 11:08:47 +0200
Message-ID: <87zexq6bc0.fsf@kernel.org>
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

On Wed, Sep 09, 2026 at 04:20, Marek Vasut <marek.vasut@mailbox.org> wrote:

> Hello Thinh,
>
> On 9/9/26 3:58 AM, Thinh Nguyen wrote:
>> On Fri, Sep 04, 2026, Marek Vasut wrote:
>>> On 9/4/26 4:29 AM, Thinh Nguyen wrote:
>>>
>>> Hello Thinh,
>>>
>>>> @@ -2709,6 +2712,27 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>>>>    			return -ENOMEM;
>>>>    		}
>>>>    	}
>>>> +
>>>> +	if (gadget_is_superspeed(gadget)) {
>>>
>>> Nitpick -- you could invert the conditional here and reduce indent:
>>>
>>> if (!gadget_is_superspeed(gadget))
>>> 	return 0;
>>>
>>> ...
>>>
>> 
>> But wouldn't that deviate further from the original Linux
>> change? See:
>> 
>> 4bb99b7c82ba ("usb: gadget: storage: add superspeed support")
>
> I think we are past that point and the U-Boot code did already diverge 
> quite a bit, but if this is pulled from some specific Linux commit and 
> you want to retain the code similarity, then please at least include the 
> aforementioned Linux commit reference in the commit message.

I've been (over-)zealous with keeping the code similar to the Linux
commit.

Sorry if that was a problem.

To me it looks good this way.

>
> 'From Linux 4bb99b7c82ba ("usb: gadget: storage: add superspeed 
> support").' or something along these lines.

I can add that to the commit message when applying.

>
> Thank you !
>
> -- 
> Best regards,
> Marek Vasut
