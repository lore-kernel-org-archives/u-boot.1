Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C36ECD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AEF845E3;
	Mon, 18 May 2026 12:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ipxe.org header.i=@ipxe.org header.b="XsCn1etm";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="2Nl4fvUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CA88460E; Mon, 18 May 2026 12:51:59 +0200 (CEST)
Received: from a7-20.smtp-out.eu-west-1.amazonses.com
 (a7-20.smtp-out.eu-west-1.amazonses.com [54.240.7.20])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE8083EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=0102019e3ab6c16b-49aba3f8-89be-4377-b99a-55c7584a54ac-000000@eu-west-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=cphpx6z2rfcgehlykjjh3gknqe3hsoe2; d=ipxe.org; t=1779101516;
 h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=KSrG+dIh8M+M3LEl0eYA9dLEeJWOqGqcpblfr5ebpMg=;
 b=XsCn1etmBlCuA9jM9ciukBujsyDoTUdTY2HRwAqzgMOOWh5RZ7zaaHCCD5H0pjm+
 m+Qe3tJLVPnIVYwODyXF6PktGmyTwP2MElV1qvjmmAvWLlkdG+C8BE5yhySsG33ssWt
 ccFO8Mi8i7JOffD1jvofHJcjq2cgULWz3NFlmMzdLi2v54mC8wzPPHCFweLfawzVVO6
 HzYiG8xxa+zdlrXsypsL99OGb19JToWlppylwCobTg/GA5wBpQZFQrvcQcKwzsEs0bL
 Z6W38jg+bDG2nQdTnXtwNYOfd7zP5rrj75VgeQHP+k3vhNCAxcQOQfraftsHcDkRLQt
 HrrbdwMqFQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1779101516;
 h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=KSrG+dIh8M+M3LEl0eYA9dLEeJWOqGqcpblfr5ebpMg=;
 b=2Nl4fvUCuAduotlNMVA/T6C0trCAgTsL8SuEg+HkY6+AEv5orGCRzACMV4i+LzQ3
 whMqSDIdXGQL+8px5462wL6qI7vnDRMP81kO+r7kqx0bdEyqRWC33qfICwaDLMVYWAh
 /9iqmKR1aGJGxpgw5ryN2jcQchA2NFbideC9ymFI=
Message-ID: <0102019e3ab6c16b-49aba3f8-89be-4377-b99a-55c7584a54ac-000000@eu-west-1.amazonses.com>
Date: Mon, 18 May 2026 10:51:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] efi: fix and test hii keyboard layout pointer
 computation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
 <B11344DB-FD58-478D-A9BD-5081C48116D3@gmx.de> <agrga7jakYcRlzEK@debian>
Content-Language: en-US
From: Michael Brown <mcb30@ipxe.org>
Autocrypt: addr=mcb30@ipxe.org; keydata=
 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
In-Reply-To: <agrga7jakYcRlzEK@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2026.05.18-54.240.7.20
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

On 18/05/2026 10:48, Vincent Stehlé wrote:
> On Tue, May 12, 2026 at 09:05:29PM +0200, Heinrich Schuchardt wrote:
>> Did you find any real use for HII protocols in U-Boot except for running the SCT?
>>
>> Are HII based EFI applications a thing?
> 
> Hi Heinrich,
> 
> A fair question indeed, as the HII protocols do not seem to be used that much in
> practice.
> 
> The UEFI Shell seems to be using them, though, which should be a sufficient
> reason to support them, I think.
> 
> Those protocols are used as well a little in systemd-boot and iPXE for example,
> but as far as I can tell, they are not used at all in Shim, GRUB, Linux, Xen,
> the BSDs or Android GBL.

For the record: iPXE has zero interest in almost all of the HII 
protocols.  We provide an HII interface to allow external utilities to 
read and modify iPXE settings, but I don't believe anything actually 
uses this interface.  (There are some comments about the HII config 
protocols at 
https://github.com/ipxe/ipxe/blob/ca85200809eb0bf5571869264cb2bf7f0548180a/src/interface/efi/efi_snp_hii.c#L30-L49)

The only use case that iPXE itself has for any part of HII is the 
EFI_HII_FONT_PROTOCOL, which we use to obtain font glyphs in the cases 
when we are drawing our own framebuffer console instead of using ConOut.

Thanks,

Michael

