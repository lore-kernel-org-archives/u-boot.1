Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FFEC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 19:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB8D87F41;
	Mon, 18 Mar 2024 20:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dU1ix5Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8276D87150; Mon, 18 Mar 2024 20:59:50 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE80A87FFA
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 20:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ptosi@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5687e7662a5so6355831a12.0
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710791987; x=1711396787; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zSDUNgiEzpIR/4bn9WUqFOUwaPUDizuDIVi3T9AVG/I=;
 b=dU1ix5Ycqyu/q/K7aVqR4jpB6TGfj3LQ/BlysXYW+5ghmoM8cJ+swhPQvJOE04+4Xe
 7tET/qd3kpOFj6zoP5S8rI2mCrdiZdFgxdNW/hcB7nmXx6aRw2NE/Q8MZi/r06YmOR2q
 qiT5C6gLjGTlVhWtByDM9L1MYru/dPE7b1MA6rkAHDLds3vRgSPvc2KLXxBzkackElt0
 uT91ec79f3HXkIPtaWLb1TLkVvbwpbd9uoEcLc6ucte2pCJxMDuHI8umPrxmee7oOcCq
 kiRBeUHB5vLXVuZK71l6secfgchNTztRVlpWOKibgFpD1nw0+xqp9F/PB2qLqJ2XDp90
 tZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710791987; x=1711396787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSDUNgiEzpIR/4bn9WUqFOUwaPUDizuDIVi3T9AVG/I=;
 b=ZClbwsoSKH+SyyVtQhRf7A1beIMNt8do2mEDap5tgFVfMD8bTkeQtZQNvl8SFAoGiH
 53jFcU70EWjqjZ+E0aER497yzvVb7IFPcJAdkMqFPCHL3KoqwKFlR186dtXGPvFCiA1F
 k0cRPqPCic/DNflafNpnfQIuEGvmg29h5cRiA1ErCPqWfpEQQQ0FMexuWF0XeN3IBdto
 KYBhzRi0xHGrGggqoBpqk9SPc7zkaWyPEDcGm3o1LeG5EnGQ96wb3i7e38nArszck/gx
 GwL2oyypc/3HQuLicpGZILSS3LOlkKS77YmeDxbWm/Z9yGHhWPPlOLO1kR+Ep8rblTIB
 mZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmN64z7AkBhGWsBOqCLgiTWXvsfEpcTBaZxqYr6wBfr5v0j3ORrXgH1+BRErtN9bchmGpVjMshLIledsem2RvM12qvBg==
X-Gm-Message-State: AOJu0YwI2Sg0lPsjdAL545snExgFgncwPscKKQSU+6sJLvOXxGQ9Qv/y
 3mH0VDj/Polq1CWfGXKIrfr0kEgTf8YtYb1RNAPEY15GbGcjunrYtI/ZoRfRgg==
X-Google-Smtp-Source: AGHT+IGnpmqFRl8VnVlPfAA2HxNll6pYL92ZIfqPwpofLlAP9kAHnKTaPtYVuKq6MBVr1eO1yek/BQ==
X-Received: by 2002:a17:906:1d03:b0:a46:a928:3034 with SMTP id
 n3-20020a1709061d0300b00a46a9283034mr209305ejh.18.1710791987154; 
 Mon, 18 Mar 2024 12:59:47 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com.
 [34.90.227.64]) by smtp.gmail.com with ESMTPSA id
 my10-20020a1709065a4a00b00a466591eaebsm5181730ejc.194.2024.03.18.12.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 12:59:46 -0700 (PDT)
Date: Mon, 18 Mar 2024 19:59:42 +0000
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
Message-ID: <gjz5nphb23536caq63gyqavrm2kwr2oxwzolrbjlvxks5fomx5@4c6zmshqowdz>
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
 <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
 <87zfv7pojq.wl-maz@kernel.org>
 <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
 <CAOMZO5CqH1OuVQDNH7+CuzPbBt9M8F7OOhDgCZZ0ad7rBfT52w@mail.gmail.com>
 <vozturnswioy4b46tp5j45tq4kv7gnfkklwnw2bipn3mi3q2zi@4f4q2bwf7qun>
 <CAOMZO5D0TeJ8BDCZ73Txq_OvxcNN8KAASOgyzAU3EYtR7igAsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5D0TeJ8BDCZ73Txq_OvxcNN8KAASOgyzAU3EYtR7igAsw@mail.gmail.com>
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

Hi Fabio,

On Mon, Mar 18, 2024 at 10:31:25AM -0300, Fabio Estevam wrote:
> Please find the new logs here:
> 
> https://pastebin.com/raw/qF3GbJry

I notice that the mem_map in these logs have overlapping ranges, which results
in unnecessary work when creating the PTs. For this reason, it would make sense
to prune it in arch/arm/mach-imx/imx8/cpu.c before calling dcache_enable(), IMO.
On this point, you also have contiguous ranges with identical attributes
(mem_map[0] and mem_map[6]), which could be merged into a single entry. This
could result in more efficient MMU mappings if the mem_map entries can share a
block mapping. Also note that mem_map[4].size=0 so could be dropped.

In any case, if we assume that overlapping mem_map entries are a valid input to
the arch code (maybe not as it leads to potentially ambiguous behavior?), then
41e2787f5ec4 had removed support for splitting existing block mappings.

In your case, my assumption is that the function was then treating block
mappings in the range 0x1c000000-0x80000000 (which get mapped, at least
partially, by mem_map[0], mem_map[1], then mem_map[2]) as table mappings and was
issuing read/write instructions in that range (accessing them as PTEs). As those
seem to be device memory (I see they get mapped as MT_DEVICE_NGNRNE), these
accesses might explain the SError you were experiencing.

Would you mind testing [1] and giving it "Tested-by:" if it addresses the issue?

Thanks,

[1]: https://lore.kernel.org/u-boot/43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5/

-- 
Pierre
