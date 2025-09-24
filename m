Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE87CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 13:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAD483447;
	Wed, 24 Sep 2025 15:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FCB8349B; Wed, 24 Sep 2025 15:31:32 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A274B800D7
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 15:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [143.105.119.198])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 18F95B220249;
 Wed, 24 Sep 2025 15:31:25 +0200 (CEST)
Message-ID: <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
Date: Wed, 24 Sep 2025 06:31:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Nishanth Menon <nm@ti.com>, Aristo Chen <jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, al.kochet@gmail.com,
 paul.henrys_ext@softathome.com, bb@ti.com, y.moog@phytec.de,
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com,
 n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, d-gole@ti.com,
 ravi@prevas.dk, carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de,
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250924114317.742ae4ntrb4mvuyq@expert>
Content-Type: text/plain; charset=UTF-8
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

Hi Aristo,

On 9/24/25 04:43, Nishanth Menon wrote:
> On 06:37-20250924, Nishanth Menon wrote:
>> On 10:59-20250914, Aristo Chen wrote:
>>> This patch series enhances FIT image robustness by adding **memory
>>> region overlap detection** to `mkimage` and fixing existing overlaps
>>> in DTS files and `binman` tests.
> 
> [...]
>>>
>>
>> Looks like i see a build regression in linux-next after this series.
> 
> I fat fingered that one.. sorry, I meant u-boot next.
> 
> 
> Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> 
>>
>> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> 
> I  believe there are outstanding comments on V1 that have'nt been
> addressed either. Can we revert/drop this series for now while the
> comments are addressed?
> 

Similar to Nishanth, I am seeing a build regression, itb.map:

ImagePos    Offset      Size  Name
<none>      00000000  <none>    itb
<none>      00000000  <none>    fit
<none>      00000000  000c1698  uboot
<none>      00000000  000c1698  u-boot-nodtb
<none>      000c1698  00202128  opensbi
<none>      00000000  00202128  opensbi

Yields this error:
...
 MKIMAGE fit-dtb.blob
Warning: not able to get `load` of node 'fdt-1'
Warning: not able to get `load` of node 'fdt-2'
Warning: not able to get `load` of node 'fdt-3'
Warning: not able to get `load` of node 'fdt-4'
Warning: not able to get `load` of node 'fdt-5'
Warning: not able to get `load` of node 'fdt-6'
Warning: not able to get `load` of node 'fdt-7'
  CAT     u-boot-fit-dtb.bin
...
  MKIMAGE u-boot.img
Warning: not able to get `load` of node 'fdt-1'
Warning: not able to get `load` of node 'fdt-2'
Warning: not able to get `load` of node 'fdt-3'
Warning: not able to get `load` of node 'fdt-4'
Warning: not able to get `load` of node 'fdt-5'
Warning: not able to get `load` of node 'fdt-6'
Warning: not able to get `load` of node 'fdt-7'
  COPY    u-boot.dtb
  MKIMAGE u-boot-dtb.img
Warning: not able to get `load` of node 'fdt-1'
Warning: not able to get `load` of node 'fdt-2'
Warning: not able to get `load` of node 'fdt-3'
Warning: not able to get `load` of node 'fdt-4'
Warning: not able to get `load` of node 'fdt-5'
Warning: not able to get `load` of node 'fdt-6'
Warning: not able to get `load` of node 'fdt-7'
  BINMAN  .binman_stamp
Wrote map file './itb.map' to show errors
binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning: not able
to get `load` of node 'fdt-1'
[Config: conf-1] Error: Overlap detected:
  - uboot: [0x40200000 - 0x402c1698]
  - opensbi: [0x40000000 - 0x40202128]

make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] Error 1
make[1]: Leaving directory '/home/es/build/u-boot'
make: *** [Makefile:198: sub-make] Error 2
make: Leaving directory '/tmp/u-boot.2.git'

If you would like to reproduce the issue, use config
starfive_visionfive2_defconfig and pass to OPENSBI env variable the path
of opensbi object 'fw_dynamic.bin' built using PLATFORM=generic, with
the ordinary gcc riscv64 toolchain. The starfive visionfive2 board
target in U-Boot supports multiple vendors and boards selected at
runtime and is an example of a more complex FIT usage that you may be
interested in for comparison and testing.

Best regards,

-E
