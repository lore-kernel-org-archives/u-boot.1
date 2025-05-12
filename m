Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA878C3ABCD
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 11:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6576C80C83;
	Mon, 12 May 2025 13:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D78826AA; Mon, 12 May 2025 13:53:03 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796E480050
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 13:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 21D29B4C1038;
 Mon, 12 May 2025 13:53:01 +0200 (CEST)
MIME-Version: 1.0
Date: Mon, 12 May 2025 07:53:01 -0400
From: e <e@freeshell.de>
To: Leo Liang <ycliang@andestech.com>
Cc: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>, Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Maksim Kiselev <bigunclemax@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>, Chia-Wei
 Wang <chiawei_wang@aspeedtech.com>, u-boot@lists.denx.de, Han Gao
 <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 02/10] riscv: dts: th1520: Add clock-frequency for UART0
In-Reply-To: <aCHF-zLg41oOXdTl@swlinux02>
References: <20250426165704.35523-1-ziyao@disroot.org>
 <20250426165704.35523-3-ziyao@disroot.org> <aCHF-zLg41oOXdTl@swlinux02>
Message-ID: <c37ce687674984589e56d2edb0184e48@freeshell.de>
X-Sender: e@freeshell.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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

On 2025-05-12 05:57, Leo Liang wrote:
> On Sat, Apr 26, 2025 at 04:56:56PM +0000, Yao Zi wrote:
>> [EXTERNAL MAIL]
>> 
>> The BROM of TH1520 always initializes its clock and configure the
>> baudrate to 115200. Add a clock-frequency property to provide such
>> information without introducing CCF to SPL.
>> 
>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>> ---
>>  arch/riscv/dts/th1520.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

NAK from me. Quoting Emil "The uart0 node already has a reference to the 
uart0_core clock, so it shouldn't
need this property." If SPL does not support the clock framework to do 
this parent node lookup properly from device-tree then we should not be 
adjusting the device-tree in this way; use instead the codepath in 
serial driver that checks a compile-time define.

See for example: 
https://lore.kernel.org/u-boot/20250503115301.972550-1-e@freeshell.de/

- E
