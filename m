Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B34CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86680811B6;
	Fri,  2 Oct 2026 09:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VwHViwmugUoh; Fri,  2 Oct 2026 09:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C15B81167
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790934193;
	b=dii+a24nodSg4piTrwTMdWKQ0q9d1Ks1YapRf5aL2XUr8hUn6VHT5gGoAi8A3y1RGkpi
	 z3xFmnJLlXr11kV2GNTMLSZLLvPC1evw+0HceNVqaRnNnsNxvjAEHNaPjD2HHdh7wwR6k
	 4mMhJmchcvD64y7DsCqse3EkV46ZRnyfQAK/noqkduszFJd4VFc3PH0bz5Ci2D7+6Dbhj
	 ya/U8WS2fUJmVb38bsZlPVEw5gWE6pqFugBDSG++6XtjYiHJj0NwhcXkkoFK4kEMTcoag
	 B8HB2i1wjfvTl/Gut53JFMBHib88WxQJ795KeQykBiiKbrK8ACOhVjRplYdsshhR+0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790934193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GPQNRjZBRg/REDXWDcFkIq11njHu3nYxg+5qH1Eogd4=;
	b=SR8VUnZNLXcofDcYwRmdtI252CsxOyTNWMNbnRgdHeN4+qeLC9MrqD25KB+2sHrTl0/8
	 siHhd8wYVpuV2gV/zezcLdphEzdMcybxK9HtU9botc+dfPI75Gc9H2ta8fDoD5Ae5j7sP
	 2fTbQh5l5rlbZOqYL4JmCrcs56fNnUGCpaEE3pFm7UStw76BzS6PsGiabVzGn4WR5mcJq
	 UqG1UADUH5Qkb7/jhLGpQRyuT+xmOwPBEumWgSimsZ40FLmzbJpbqYRxXeN/BsmF+ubAe
	 ++0lenc0N8C0F82p5y/dKKwmFJ0JHsM0329BfhhZgi8TtIyH3d5WpZaZQujDwDYlWew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790934193;
	bh=GPQNRjZBRg/REDXWDcFkIq11njHu3nYxg+5qH1Eogd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVHjRHlBuSNR3gEdvaQ4c3UlX9sqgz8Yer+mBkA0VUr4Ayw80VfC6SeQCMeec+FOT
	 ftb1qW1IKeotXPp61aD1Uy13tyhkSZVy+38LF1/zzgJw1dvOtDTySxIw+aoDR8Tnv5
	 Q1z/8Hi/90jENkoVbxvT4i9YjcrZYMOlY5TXapjRn3GmWsEB5+6iQanAi3Bn9bMyuI
	 OtKkdpJKeUYyX/pHF1CnU2vca+8qsiRgvDWcDDMCxKyzKF+RjVcPNiOBYK79CRVLIW
	 o7e1JAz6C7gjKrCYMRXvXV3KzjHFZmtfarYPaG/35wnKuIg5moz/vQP4Pd2Rp4Xm7C
	 UU8SJt15ntoMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C15B81167;
	Fri,  2 Oct 2026 09:43:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CABC51A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B105C400B3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H55o18VhNhlC for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1158E4004A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=84.16.66.170
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790934190;
 b=sbhuZqse91TzqJU/jJ60eyyFmo31Kqk8coJRdHY3ArBJc3zw+2mbTndfbwvTxWnpyJFH
 CQzv8kzEZ8jFwu4Rgh+6oJd1ugWVKltulgBfUNK7PKV+BPY+uc2ULcBzBS/Me8BXjsnno
 usTictpkX6z73BzkOSEQ1e0I84EaPjqqhXxlfjLJO+DGFMcuFUTHO+Xvpg9Ka1gJNVaq/
 S2vIuu6Zh9NUfdQLG7VMvIRH/NIUydA6V94+C2MdokXZSRzvsFN0EgUvP4ivLs8UYB5yW
 6OlM8VUbLaOxYfS1otsEn7YvyD8YykyYDLVvdKPl8Ew32nj6gF6xUVJeO/R0Ley0mMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790934190;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=GPQNRjZBRg/REDXWDcFkIq11njHu3nYxg+5qH1Eogd4=;
 b=ltkJb4hu3Azu+d8wwhQ9SWUUwjc+EJMMJ15q0t43rdeN8C6tQUeL3lEopHT4MHaOigg2
 /craKfK8cYoFr4JgmHiFToWq+9PhEW3z35bZ8TtRtvg0YbGozV7XpbVMDdGg43Ur83wpi
 s6hzBNLeU9v6EWqL0EeWB/O7Vk39YxKtO97BfejmcS6ELSF9GSa3pf3cYTSm4vHiEpWiW
 kLfr2ndc8UbT9XCiFVUWfEVgNusP5jeOYZyeuk3K3I73dRPKG1c3O4Sv+79mwMrbSnuvm
 /fV39f0A167TXcD/mgGhGk+R04U7jr/m4otr0wZW5klrqP9/tctRnGRd1nFGy4VBUdQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=h5lJUjZs; 
 arc=none smtp.remote-ip=84.16.66.170
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.170;
 helo=smtp-42aa.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=h5lJUjZs
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1158E4004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:43:09 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hx3bm52lcz15Mw;
 Fri,  2 Oct 2026 11:37:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790933860;
 bh=GPQNRjZBRg/REDXWDcFkIq11njHu3nYxg+5qH1Eogd4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h5lJUjZsQdRxTAemrV/IqcV6QdWN11ElrTgn7UBt/2hFD2KIzPDsTQaOoPF7st6ZB
 Va8aUpYzl7m9ci5yRYERHE9FmYEBSy3/OWpQjW4jdYC5httaYH95T+uHOWWlmiddqj
 c/1nlqrIGJLCihHdzHFtfenqrP89nsNIByjn/AzwCAL1HF+dUEi7lyyNTQzbpZLQe1
 sZU84HA/mM7jvfxoWYdsf6/tdhq4MsGF8X3Rtx2VWm/B4puzcq87nqtaq6F+VoUXBm
 KIymhI7X+xSscJn9sBgWQMieKnx5T8FbDrCGEXKdWSuwwgI7q+W6bi8ISL7NltUR9k
 eKtr4TGxzlNGA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hx3bl5nGGz5Fv; Fri,  2 Oct 2026 11:37:39 +0200 (CEST)
Message-ID: <bbca02c0-ed81-4a78-8861-43b69eefbcb1@0leil.net>
Date: Fri, 2 Oct 2026 11:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: rk3528: NanoPi R28S support before dts/upstream
 sync
To: =?UTF-8?B?5a6J5a65?= <HystericalDragons@proton.me>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>
References: <OjXy0xMi4UhaNlSDbglwvkf_FXX3Kg2TzBsaucWmd7YnY4tVJXGpdp-sUp-mApm8Zh9935uuKq1jhneCiItNCisIRiN66zEG8zl1jiGBFMI=@proton.me>
 <be3cd318-cba7-4c04-914b-e859c222ddaf@0leil.net>
 <wZ90PLwVcDDHWjgk7robBmaw1YmdSxF2l4qP0CirT50SG0pcnFMha3Ahz00Hzo_ZyZd5DGXiVDruI_ic8UhKYUIlRcDyCCy8LrH0ZtulEnY=@proton.me>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <wZ90PLwVcDDHWjgk7robBmaw1YmdSxF2l4qP0CirT50SG0pcnFMha3Ahz00Hzo_ZyZd5DGXiVDruI_ic8UhKYUIlRcDyCCy8LrH0ZtulEnY=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

Hi Rong An,

On 10/2/26 3:24 AM, 安容 wrote:
> [You don't often get email from hystericaldragons@proton.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Quentin,
> 
> 
> On Thursday, October 1st, 2026 at 5:18 PM, Quentin Schulz <u-boot@0leil.net> wrote:
> 
> Thanks for the detailed explanation, that makes the process clear.
> 
> I'll prepare the series and send it for review, with a note in the
> cover letter about the dependency on the two devicetree commits. Once
> they are available in devicetree-rebasing, I'll pick them with
> tools/update-subtree.sh and include them in the next version.
> 
Sounds like a plan!

>> https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fb4.docs.kernel.org%2Fen%2Flatest%2Fcontributor%2Fsend.html%23authenticating-with-the-web-submission-endpoint&data=05%7C02%7Cquentin.schulz%40cherry.de%7C70d7be758fe04bf874eb08df2024629c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639265012795015084%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=RTGqpuJ%2B0%2Bx22TCNumDrT9uuiOCqeJj%2Fe0GFQ5T2a4w%3D&reserved=0
>> should allow you to send patches with b4 without your own SMTP server.
> 
> I actually used the web submission endpoint for the devicetree patches
> on linux-rockchip. As far as I understand, though, it only delivers to
> kernel.org addresses, so it can't be used for the U-Boot list.
> 
>    https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fkernel.googlesource.com%2Fpub%2Fscm%2Futils%2Fb4%2Fb4%2F%2B%2F9186f8a042abb29c90db79fc70967d0d88236d10%2Fmisc%2Fdefault.conf%2327&data=05%7C02%7Cquentin.schulz%40cherry.de%7C70d7be758fe04bf874eb08df2024629c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639265012795038418%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=W2RD2Rzh%2FlMcYp511wK11b7zOfaqv9caABK3vPOVEmk%3D&reserved=0
> 

https://lore.kernel.org/u-boot/20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com/ 
has the "via B4 Relay" I would expect when using the relay and there's 
no To/Cc matching the rule above. Can you give it a try? Maybe that just 
works?

>> I have seen some proton.me senders for patches, are you implying they
>> are all paying to be able to send patches?
> 
> Yes, I believe so. Proton Mail Bridge, which provides local SMTP
> access, is only available on paid plans. I'll subscribe so that I can
> send the patches myself.
> 

See https://git-send-email.io/ (hit next once), they list tools that 
supposedly work with free accounts too, that could be an option before 
going the paid route.

Cheers,
Quentin
