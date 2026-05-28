Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5814ACD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 16:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B45839A8;
	Thu, 28 May 2026 18:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="lc9nUVuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8C883FF5; Thu, 28 May 2026 18:17:14 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B9EA80087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 18:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C9D2927113;
 Thu, 28 May 2026 18:17:11 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ye9SNJFiQTpZ; Thu, 28 May 2026 18:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779985031; bh=9OAx+xAroR5Ty7ailOo2ogxrcGug4Wn4475SRo18MBQ=;
 h=Date:From:To:CC:Subject:In-Reply-To:References;
 b=lc9nUVuzL9edUnAYMaXBMR260Oq1C4NzkBjcfAk4ThawfzfOcS1bv8HZQY0kOcJSi
 PZAJvKUvZNotr52mvct08sZ85qPunkyAhdvQS38Rt/mD6ew418tlDZPgJs58E9m2An
 pVwzWmPYziyZXoc37BX5sIY+79I7DbUENCGbYB6nLInPwWqWA2evyaBz6YJe53KJUe
 +av47ZmZrSE8yYxX5TG1lLKlTzyeAwp5AjxkcOOG5JKNWTn+fKp/T5/di+dBTO3CbV
 K63ctLfNAQ0UcGe/JOnPb5Y65BJ09CdRZ/+xUN62+g21EHk4+P+oAYzQqapSZbF4Kn
 94UNUGLY8FZOA==
Date: Thu, 28 May 2026 17:17:10 +0100
From: Josh Law <josh2@disroot.org>
To: Tom Rini <trini@konsulko.com>
CC: "Lee, Brian J" <hibrian827@gatech.edu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kim, Youngjoon" <ykim3186@gatech.edu>, sjg@chromium.org
Subject: Re: U-Boot TFTP OACK option parser reads past unterminated values
In-Reply-To: <20260528154745.GE93986@bill-the-cat>
References: <DM6PR07MB43775463F18267C7C1AE8981F6082@DM6PR07MB4377.namprd07.prod.outlook.com>
 <8C6CF5D6-B9A5-4837-8D4C-86E151C7A617@disroot.org>
 <DM6PR07MB4377F2C4B242629F7E4FE52DF6082@DM6PR07MB4377.namprd07.prod.outlook.com>
 <E4D3C94F-5528-4BFE-9B8C-55CEC835E6B4@disroot.org>
 <20260528154745.GE93986@bill-the-cat>
Message-ID: <385E8153-51DB-41C8-8B1B-D1AF04CEF6A4@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On May 28, 2026 4:47:45 PM GMT+01:00, Tom Rini <trini@konsulko.com> wrote:
>On Thu, May 28, 2026 at 03:46:51PM +0100, Josh Law wrote:
>> On May 27, 2026 7:55:58 PM GMT+01:00, "Lee, Brian J"
>> <hibrian827@gatech.edu> wrote:
>> >Thank you for the acknowledgements! I apologize reproducing the PoC had
>> >difficulties due to poor quality. I will make sure to improve that.
>Thank
>> >you!
>> >
>> >Best regards,
>> >Brian
>> 
>> Hey Brian, sorry for the unexpected email
>> 
>> 
>> After playing with my server slightly, I got your script running :)
>> 
>> [run.sh] reusing existing
>>
>/home/josh/stuff/u-boot/INT-tftp-uboot-short-ack-oob/INT-tftp-uboot-short-ack-oob/poc/source
>> at
>> 215496fec59b3fa09256b4fb62f92af46e2ec7f9
>> ERROR: AddressSanitizer: heap-buffer-overflow
>> 
>> I've CCed more people who can help you here.
>
>All,
>
>I'm sorry that if in the end it turns out I'm wrong here, but given all
>of the public evidence:
>https://lore.kernel.org/u-boot/c67720e2-bb73-43ab-9d75-851ef1f4afaf@kernel.org/
>https://lore.kernel.org/u-boot/ahXPidpyl-qRMOkH@google.com/
>https://lore.kernel.org/u-boot/64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com/
>
>I do not believe Josh Law is a human but rather some LLM agent. Please
>disregard their feedback.

Tom, you and Brian are talking to a human.

I see the situation I'm in.

I understand the protection you want to provide, (and saving maintainers
times)

I understand the concern about 
maintainer time and trust. 

If identity verification is required I am willing to discuss a private
verification path with project
leadership or the conduct team. (e.g: video call)

I am not going to post personally identifying material publicly.



>

Thanks!
