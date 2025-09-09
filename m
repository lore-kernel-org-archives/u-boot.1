Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB51CAC581
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 02:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6F580422;
	Tue,  9 Sep 2025 04:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rsF4sFx/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mroxGG4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBA282A9E; Tue,  9 Sep 2025 04:24:17 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D05800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 04:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cLSLk5bTKz9stK;
 Tue,  9 Sep 2025 04:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757384654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1SsvGXaNxKib93hn0wpUy4Cb3r9KJETmP3s7U1a0uo=;
 b=rsF4sFx/1YWYpHgb715GYfc/I3lL0pk2HyI2v+SDJ2KvWGusNKohPiGgEujyT9El51Vpcn
 5K98U8IGPCK7sjGVVQ6ywkMC/U0yN1RWaNTP9iQJpseigwdHfX9x6pI45oeJoezSQVZNYj
 XmHbsAKmVppPv6AswcIUiS7f3ErW1g55kGDa4WJhE26Yy6E39ZTWvotR0qaL3S7nQXM9gs
 1SOVhOhc+5vIFzBiXWV/jc/RfY2gF8ys/mAO6BWXTED7+6Kl/Kn90F4dELeOl+ThacOIrN
 NcLrxndLN1al210fcvE3V69SOHgbyKnTp64uoMNmwuuqq93LJd0w2iF8Roa/yQ==
Message-ID: <3c931bf8-d512-4521-bd8a-fa04d3ffb1cb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757384652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1SsvGXaNxKib93hn0wpUy4Cb3r9KJETmP3s7U1a0uo=;
 b=mroxGG4/i45VqZ0/eu7HT0InptEC7w2wI3gfebPKi76hWqNFWFTVukiS/rZF90rZMj9ksF
 wiE+EZrAcoheWp9nEYufGB9NlLa9JtuqXBInHUuKsh+nE/GIaTzEEn01pDb8YyTAYWY63G
 vdHUQRdBmYSs0uHOGbgKBb9ZLUqceVzQsgLVDLIufK1u8+vUX3aOU1FRStZoil4EXQW8zd
 MhpL400nlk+QnUVaDtcfpG0p7rNb7arin+9sClliRygf/jf1T/VPu8fG+8Wf4QA1/9lvoD
 EoRiyOZLJC4fko+cPC4femYG63CiH3MYZWluxAWA+Atw3MzDqRhT4y9gkWEFBg==
Date: Tue, 9 Sep 2025 04:24:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Love Kumar <love.kumar@amd.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com>
 <5046fa19-eab6-47fc-a740-d8f3268070f2@mailbox.org>
 <a117a5d8-c759-4fe4-bfbc-110e55a99945@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a117a5d8-c759-4fe4-bfbc-110e55a99945@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1997769ea2d6d2f7001
X-MBO-RS-META: f31xgcpjc1iybtsts5auwt7zqgc83xao
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

On 8/21/25 8:47 AM, Michal Simek wrote:
> 
> 
> On 8/20/25 22:59, Marek Vasut wrote:
>> On 8/19/25 4:25 PM, Michal Simek wrote:
>> [...]
>>
>>> ZynqMP> mtd read "U-Boot storage variables" 1000
>>
>> It would be better to spray the 0x1000 area with pattern first, 
>> otherwise, if the 'mtd read' fails, such failure might go undetected.
> 
> can be done.
> 
>>
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>>
>> [...]
>>
>>> ZynqMP> savee
>>
>> "env save" is the modern equivalent.
>>
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI 
>>> flash... offset 2200000
>>> done
>>> Valid environment: 2
>>> OK
>>> ZynqMP> mtd read "U-Boot storage variables" 1000
>>> Reading 131072 byte(s) at offset 0x00000000
>>
>> This here looks odd:
>> - Where is the "offset 2200000" print coming from ?
> 
> I had additional debugs in the code when this output was created.
> 
> diff --git a/env/sf.c b/env/sf.c
> index 0b70e18b9afa..961e853eaef7 100644
> --- a/env/sf.c
> +++ b/env/sf.c
> @@ -127,7 +127,7 @@ static int env_sf_save(void)
>          if (ret)
>                  goto done;
> 
> -       puts("Writing to SPI flash...");
> +       printf("Writing to SPI flash... offset %x\n", env_new_offset);
> 
> 
> 
> 
>> - The valid environment is indicated to be 2 , shouldn't that be 1
>>    (primary copy = 1, redundant copy = 2) ?
> 
> yes it should be 1 but this is the code before this patch is applied and 
> it is saying 2 but actual write is happening to 1.
> 
> 
>> - The dump of what looks like primary copy also seems valid, so
>>    shouldn't Valid environment be 1 (see previous bullet)
> 
> yes - dump is valid because the first write is happening to primary copy 
> but logic itself is saying that it was saved to redundant copy. And 
> that's exactly what my patch is fixing.
> 
>>
>>> ZynqMP> md 1000
>>> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
>>> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
>>> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
>>> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
>>> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
>>> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
>>> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
>>> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
>>> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
>>> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
>>> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
>>> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
>>> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
>>> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
>>> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
>>> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
>>> ZynqMP> mtd read "U-Boot storage variables backup" 1000
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
>>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
>>> ZynqMP> savee
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI 
>>> flash... offset 2200000
>>> done
>>> Valid environment: 1
>>> OK
>>> ZynqMP> mtd read "U-Boot storage variables" 1000
>>
>> This behavior here looks correct .
> 
> yes for primary yes but secondary should be populated already based on 
> log above but it is not.
> On the first save you should save variables to primary, on second save 
> to secondary.
> 
> As you see from logs. On the first save - the first location is used but 
> u-boot reports that it was saved to 2 redundant location. On second save 
> it is saved to the first location and also said that it is the first.
> 
> But after this patch applied. On the first save - the first is used 
> (unchanged behavior) and it is reported as the first (fix the report). 
> On second saving the second location is used (fix) and it is reported as 
> 2 (fix).
> 
> 
>>
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
>>> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
>>> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
>>> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
>>> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
>>> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
>>> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
>>> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
>>> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
>>> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
>>> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
>>> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
>>> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
>>> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
>>> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
>>> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
>>> ZynqMP> mtd read "U-Boot storage variables backup" 1000
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
>>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
>>> ZynqMP> savee
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI 
>>> flash... offset 2220000
>>> done
>>> Valid environment: 2
>>> OK
>>> ZynqMP> savee
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI 
>>> flash... offset 2200000
>>> done
>>> Valid environment: 1
>> It would be good to validate that both copies of the env are actually 
>> written where they are supposed to be written . This part is missing 
>> from this test. And in fact -- it would be good if this fix did have a 
>> proper test .
> 
> I can validate it again but even now log is too long now.
> It is just demonstration that at start you get two saves to the same 
> location. When 2 saves happens behavior is correct.
> I think it will be good if you can try it on any platform which this 
> enabled to see if you can demonstrate the same problem.
> 
> Love: Can you please take a look at if this can be added to pytest?
Sorry for the delay.

The change looks valid. Test would be real good to have. Commit message 
could really use improvement/rewrite, because that one is really confusing.
