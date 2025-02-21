Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD720C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 21:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2C28056B;
	Fri, 21 Feb 2025 22:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="HLNGcLf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A17806FE; Fri, 21 Feb 2025 22:31:47 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BBE800C1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 22:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54622829175so2314688e87.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1740173504; x=1740778304;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7ShLmUTEpW5LLcZFiqCuL+kc2iYV0X9KW4CSsRBXwM=;
 b=HLNGcLf09BuH12LIRZOSVHx1CoS7VdidKb23XIwH0/wBWndyLMMXvH1xg7QIixP1qR
 SsMP92r+lWt4XPM5nXIjerGScRZ/ht4oTrrpQAi+0aeXRJNve6XW+YdOUBc1q2u87AN7
 HxIJ75Tl+1lxanXCnGxbb/+LmnN0PA4C9KhKX9zTMMykKJA3zwNS4MWX/mcd7hTFPFPA
 sTeHFSebVZ5D+IGs9FVUyr4AtMXcdgluzbqgOVTAJdokLRRz0povGuRhxDfVBAAJaYZt
 k5ev72mytgO4HrTh+p9697zjrM//1K3SotKGZiNzIX0RhXfA/b/iH4DjEU4QoZ89XZ4x
 WTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740173504; x=1740778304;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7ShLmUTEpW5LLcZFiqCuL+kc2iYV0X9KW4CSsRBXwM=;
 b=iSbhLCk7kXjcr+XZvJLlZuOWIwZUuqbJiandWgC2XSLR0Bt1e/nQI/qbia5sahAFs6
 1+EH0sX2P5wErjyvUVutXzAn7e4JKslhEdwO2f9Tx5ZjIY0Y0np5kFIdG8DBEq3O06eI
 4ki5g9TZPKlD9xUwOLEKPSHiglPsyyBwKtfxBV4OjZnlZ7pgg74v3NWe3sG8jPc7ExD1
 Zht+dlssTS8jY4Icpojt5TSEypinD7U17g2JrEgazCJ4+dC45AmIMoz+IMW2+qRj3PHz
 Ws8bX0wNKfZDyIv9sHGb+hZe/FSpQArA8AWpfk6CGhDqphR+LHKXyO4hOxnyPwwrEL8A
 spFA==
X-Gm-Message-State: AOJu0YxphxeRIDDRSNFUUBe6cI6oOrjlQJnSCCnC6fsRGemJ4Zb05M+X
 UaSLJHY3pJ0pp1mIAfLHaRJP4cDSm1GOIcQ8UmZnQnCiIYRnTX3dfdghgtb0v4E=
X-Gm-Gg: ASbGncugJkFsWIsYeaY5yYwevjmfo/1WEB4wlXCh6BLa3eHBrN5+6V00sLkgYmxL3O1
 Waw9llLxLNHI2/xayFwmmrufXMo30WOnYw2BMBviJiGkKoD7YVZDmgB6C6w0Zv0JBqimq81b8oI
 67i45QYl4noDR6gErWPsGTyS8HfpV2YwC+yBl0U9ITMK5hy9jR5oPkpG69jCw8Dp5IFd/6c48GM
 4G3LNEfWEfvVyN2BQ8scuM72RWemens+MzySOhfclCef+3GbhyKSmQDvt5s3rNinrlNkpwt56iq
 tQLBU25YI6Ryi8WC7ukYMiP8JrqOGsXDiKNPgVORLsPWKYmjvpSNzR0kGBM=
X-Google-Smtp-Source: AGHT+IFh2gVWHBE5uD+1QiTh0yYhVyCWwaURFYN7mpgynoF3ueGpw8Vedq1Y7yh++ieW5HtkfzN74A==
X-Received: by 2002:a05:6512:108e:b0:545:2b24:c711 with SMTP id
 2adb3069b0e04-5483913b263mr1546326e87.21.1740173503747; 
 Fri, 21 Feb 2025 13:31:43 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-548110bf27esm359592e87.113.2025.02.21.13.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 13:31:41 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Anton Antonov
 <Anton.Antonov@arm.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH v4 5/5] blkmap: add pmem nodes for blkmap memory mapped
 slices
In-Reply-To: <CAC_iWj+a-hcvS=u_Gtk39UyjSPuMgWoao982TzN+wb5uKnS=hg@mail.gmail.com>
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
 <20250203105912.196654-6-sughosh.ganu@linaro.org>
 <CAC_iWj+a-hcvS=u_Gtk39UyjSPuMgWoao982TzN+wb5uKnS=hg@mail.gmail.com>
Date: Fri, 21 Feb 2025 22:31:39 +0100
Message-ID: <878qpzm1c4.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On fre, feb 21, 2025 at 20:55, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Hi Sughosh
>
> This generally looks ok, but I don't love the idea of unconditionally
> preserving all slices regardless of their usage.
> Basically, if a user doesn't unmap that slice it will end in kernel
> memory. My fear is that someone will forget device sensitive data in a
> blkmap....
>
> On Mon, 3 Feb 2025 at 12:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>>
>> The EFI HTTP boot puts the ISO installer image at some location in
>> memory which needs to be added to the devicetree as persistent
>> memory (pmem) node. The OS installer then gets information about the
>> presence of this ISO image through the pmem node and proceeds with the
>> installation.
>>
>> In U-Boot, this ISO image gets mounted as a blkmap device, with a
>> memory mapped slice. Add a helper function which iterates through all
>> such memory mapped blkmap slices, and calls the FDT fixup function to
>> add the pmem node. Invoke this helper function as part of the DT fixup
>> which happens before booting the OS.
>>
>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> ---
>> Changes since V3:
>> * Move the definition of the helper function to the efi_helper.c
>> * Remove the region of the blkmap mem map device from the EFI memory
>>   map along with adding the pmem node
>>
>
> [...]
>
>> @@ -680,3 +683,52 @@ out:
>>
>>         return ret;
>>  }
>> +
>> +static int add_blkmap_pmem_nodes(void *fdt, struct blkmap *bm)
>> +{
>> +       int ret;
>> +       u32 size;
>> +       ulong addr;
>> +       efi_status_t status;
>> +       struct blkmap_mem *bmm;
>> +       struct blkmap_slice *bms;
>> +       struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
>> +
>> +       list_for_each_entry(bms, &bm->slices, node) {
>> +               if (bms->type != BLKMAP_SLICE_MEM)
>> +                       continue;
>
> Can we convert the 'type' to 'preserve' and teach
> blkmap_create_ramdisk() to pass that flag?
> This way we can unconditionally pass it from EFI HTTP installers, and
> let the command line users decide if they want to preserve it.

This seems like the most reasonable approach to me as well.

Then we could add a single API like this:

int blkmap_foreach_pmem_slice(int (*cb)(void *ctx, void *addr, size_t size),
                              void *ctx);

Rather than exporting all internal details of every slice's
implementation in blkmap.h.

I.e., let the blkmap code deal with how to locate the slices of
interest, and keep the internal details away from the consumer of the
data.

With that added to blkmap.c, I think the rest of this patch reduces to
something like:

int add_pmem_node(void *fdt, void *addr, size_t size)
{
        return fdt_fixup_pmem_region(fdt, (ulong)addr, size);
}

int fdt_efi_pmem_setup(void *fdt)
{
        return blkmap_foreach_pmem_slice(add_pmem_node, fdt);
}


>
>> +
>> +               bmm = container_of(bms, struct blkmap_mem, slice);
>> +
>> +               addr = (ulong)(uintptr_t)bmm->addr;
>> +               size = (u32)bms->blkcnt << bd->log2blksz;
>> +
>> +               ret = fdt_fixup_pmem_region(fdt, addr, size);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               status = efi_remove_memory_map(addr, size,
>> +                                              EFI_CONVENTIONAL_MEMORY);
>> +               if (status != EFI_SUCCESS)
>> +                       return -1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>
>
> Thanks
> /Ilias
