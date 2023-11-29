Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BEBC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0CB86FF7;
	Wed, 29 Nov 2023 19:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OotrXOLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B8C87150; Wed, 29 Nov 2023 19:46:00 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4068186FB2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cfb83211b9so733865ad.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701283556; x=1701888356; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BgzvJXsqiXk12x5OQ30yYkVMdSSNyGahPnt5pCx3nKI=;
 b=OotrXOLF5O+3f5oBc+fQpvpdw0Kem8E7MzTMyCQmgv/pGo3Vyii41olqWQEo4f8WYv
 vwh41ct57J0DwkonDE100Xl4NQZ49daBP3Mr17zius2rL3w7cLOs/inqvvC8/Vvs4mFR
 BEnJok+nyUjGjxBrlTaLH3D9Dd06kWu8yIXpPAfzqFeIgB605p43DL9pv5yHnImlu6w2
 Y/Bzb8YACRX3IywzAKnB2QAaopf6mmmcmHNc6lWlK2npwL490Dx61/BheOCQscRmNHo3
 TuhZy3QZc2YXoOTXwb9X/fs3zFgHWVr9yujokeBWXyg3GgxDS/gniRt5corNSz5GWdXO
 Ic3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701283556; x=1701888356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BgzvJXsqiXk12x5OQ30yYkVMdSSNyGahPnt5pCx3nKI=;
 b=ipTKCttHCawz8OYXP0ZT1lAAwfEBfpbYSX2YRLZtLdFMeQDTApsBOX70OB8VN9BiI1
 va15SeB6R7/TLf5EhHKGfIcinVYz0b0la7JjkBp1ipsPvxXzhfLFG3UXCHJw6fDY+PKl
 HiXyojYSXIa4x96F3GdRHDc0Yv5N+gMVfebxgob9At3nSRXfFaELNSkNm0NKAtauwVJJ
 1rJl0VWu2ucjV4vf+tJR3+cKWB9Iqhj5eieIRf77F0sG2K8aTLAih4PS+nA+MLgfSe3K
 OKXoQpuQkvC+1iKgjlxz8YupKdj3AgmM/Deq6o7F+B8OizJ1t4IZO8Dp9yy75N7b43CQ
 0quA==
X-Gm-Message-State: AOJu0Yw1BdYW/9XZ3gf+sIqP4IKJh/JAc4IZb4hEmm6S3LRgJEccfXC4
 sDwRA+ALEHjPRsdgtVoHzmX339lLaTB9WQ==
X-Google-Smtp-Source: AGHT+IHHRFA/yjhn11mF7EsHuthWwNMt3kxvFBnhVNwPBuuoAyObJkPZIHCZ5wilv29wRamXbQJAWw==
X-Received: by 2002:a17:902:ab94:b0:1cf:ba11:1adf with SMTP id
 f20-20020a170902ab9400b001cfba111adfmr14058925plr.67.1701283556446; 
 Wed, 29 Nov 2023 10:45:56 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a170902b7c300b001cfc9ad74a3sm6779598plz.15.2023.11.29.10.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:45:56 -0800 (PST)
Message-ID: <0560924e-119b-4122-ad5b-bd563554eb10@gmail.com>
Date: Wed, 29 Nov 2023 10:45:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: OrangePI Zero3 memory timing testing
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
Content-Language: en-CA
From: Stephen Graf <stephen.graf@gmail.com>
In-Reply-To: <20231128013746.23648d39@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Some testing results:

With the default DRAM timing of 30x24=720, most often when my system 
boots it comes up with DRAM 2G, but I have a 1G system. Once in a while 
the boot shows 1G.  When it shows 2G the linux OS also shows 2G and 
continuing does not make much sense.

On one boot where u-boot reported 1G the OS agreed and I ran memtester 
successfully.

If I build u-boot with CONFIG_DRAM_CLK=792 (33*24=792) I have never seen 
my system boot with anything other than DRAM 1G showing in u-boot. I ran 
memtester successfully and this system has been stable running linux 6.6.2.

Andre, if you can put together a few patches I can test them to see 
which works.

If anyone else with different variations of the Zero3 would test with 
the two DRAM timings and report results.

I also use the Zunlong image on occasion and it consistently shows 1G 
and from my poking around I think it runs at a 792 clk.


Console output with DRAM default:

U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 22:46:39 
-0800) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  2 GiB

Last login: Wed Nov 29 09:35:15 PST 2023 on ttyS0
root@orangepizero3:~# free -h
                total        used        free      shared  buff/cache 
available
Mem:           1.9Gi       139Mi       1.7Gi       360Ki        82Mi 
   1.7Gi
Swap:             0B          0B          0B


U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 22:46:39 
-0800) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB

root@orangepizero3:~# free -h
                total        used        free      shared  buff/cache 
available
Mem:           917Mi       137Mi       766Mi       360Ki        79Mi 
   780Mi
Swap:             0B          0B          0B


root@orangepizero3:~# memtester 700M 1
memtester version 4.6.0 (64-bit)
Copyright (C) 2001-2020 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 700MB (734003200 bytes)
got  700MB (734003200 bytes), trying mlock ...locked.
Loop 1/1:
   Stuck Address       : ok
   Random Value        : ok
   Compare XOR         : ok
   Compare SUB         : ok
   Compare MUL         : ok
   Compare DIV         : ok
   Compare OR          : ok
   Compare AND         : ok
   Sequential Increment: ok
   Solid Bits          : ok
   Block Sequential    : ok
   Checkerboard        : ok
   Bit Spread          : ok
   Bit Flip            : ok
   Walking Ones        : ok
   Walking Zeroes      : ok
   8-bit Writes        : ok
   16-bit Writes       : ok

Done.

Console output with DRAM clk 792:


U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 21:34:46 
-0800) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB

root@orangepizero3:~# free -h
                total        used        free      shared  buff/cache 
available
Mem:           917Mi       134Mi       768Mi       360Ki        79Mi 
   782Mi
Swap:             0B          0B          0B


root@orangepizero3:~# memtester 700M 1
memtester version 4.6.0 (64-bit)
Copyright (C) 2001-2020 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 700MB (734003200 bytes)
got  700MB (734003200 bytes), trying mlock ...locked.
Loop 1/1:
   Stuck Address       : ok
   Random Value        : ok
   Compare XOR         : ok
   Compare SUB         : ok
   Compare MUL         : ok
   Compare DIV         : ok
   Compare OR          : ok
   Compare AND         : ok
   Sequential Increment: ok
   Solid Bits          : ok
   Block Sequential    : ok
   Checkerboard        : ok
   Bit Spread          : ok
   Bit Flip            : ok
   Walking Ones        : ok
   Walking Zeroes      : ok
   8-bit Writes        : ok
   16-bit Writes       : ok

Done.


On 2023-11-27 5:37 p.m., Andre Przywara wrote:

> 
> This symptom is pretty surely not directly related to the DRAM
> frequency, it's caused by a missing barrier or delay *somewhere*.
> People report that this is fixed by adding another "dsb();" at the
> beginning of the mctl_mem_matches() function, but I don't have a good
> explanation why exactly there, and would like to avoid submitting
> patches that "just seem to work (TM)".
> 
> If I find some time, I will try to setup some automated environment
> where I can run some experiments with different barrier locations.
> I can offer some rationale for putting it at the end of the function(s)
> that call mctl_mem_matches(), so hope that this fixes it.
> 
> Cheers,
> Andre
> 
