Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5537BE83847
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 02:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8280683AA9;
	Tue, 17 Feb 2026 03:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OTSLk9Qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377C283AC5; Tue, 17 Feb 2026 03:58:01 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7D983642
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 03:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fFPTH72Yfz9sSf;
 Tue, 17 Feb 2026 03:57:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771297076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLF9YoPeSd7cpHvbgNNQOSmwryn9bO0tGl8w2ZXt50A=;
 b=OTSLk9QgF6GmiTVbk1Yk8h62620QZ0Q19wyoC5gXsmG/xiCTGDeD5dShe0k0Wk+rvljb5F
 aFJ8yBx6xAqzo8jUmOhGfEFCjGA87MJ1wpw/22mrZQyV01DqcoFRekl/3kJOex0+FIigyq
 NXsFufgecNyD+V1xzKS8e0/JU4PX74yf+AQYklCVATKz220mOIYrWW40T9S4GOFRJuAyht
 AGKYlicE2JRio3DilG9ZtdOCYt94hc6P3o4/jCcvBursqdi2MPlQi+v4tLhJNiZu+8HN7Q
 yYUqFUjkdvSHHEoulCZbgL8jWkl/tdZh9W9rX17W/DZTUIUfq+Ck28Qbxe2lTg==
Message-ID: <dd636864-2e3e-4701-9e42-fd32353afe92@mailbox.org>
Date: Tue, 17 Feb 2026 03:04:09 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand FIT
 loading
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <49aa54f6-78a0-4eb4-bd60-d7e17263e586@mailbox.org>
 <aZPB8o9bvkNNpGT6@makrotopia.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aZPB8o9bvkNNpGT6@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ko8oofgw7crj91jjke54w6xhd79rf8gi
X-MBO-RS-ID: 68ce188e9b198f94260
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

On 2/17/26 2:18 AM, Daniel Golle wrote:
> Hi Marek,
> 
> thanks for taking a look at the series!
> 
> Let me reply inline below:
> 
> On Mon, Feb 16, 2026 at 11:16:24PM +0100, Marek Vasut wrote:
>> On 2/16/26 10:21 PM, Daniel Golle wrote:
>>
>> Hi,
>>
>>> This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
>>> embedded rootfs" firmware model, along with the underlying infrastructure
>>> to load FIT images on-demand directly from storage devices without copying
>>> them entirely to RAM first.
>>>
>>> I would like to discuss the design with U-Boot maintainers and fellow
>>> OpenWrt developers before submitting a formal patch series.
>>
>> [...]
>>
>>> 4. On-demand loading: None of the existing methods support loading FIT
>>>      subimages directly from storage. OpenWrt's FIT images typically
>>>      contain a 5-20 MB squashfs that does NOT need to be copied to RAM —
>>>      the kernel maps it directly from flash. The bootloader only needs
>>>      to load the kernel and DTB (~5-10 MB), not the entire 20-50 MB
>>>      container. This requires a new loading abstraction.
>>
>> Isn't this partial loading exactly what SPL does when the fitImage is
>> generated with external data (mkimage -E) ? SPL loads and traverses the
>> tree, and then loads the remaining chunks (files) only when needed if I
>> recall it right ?
> 
> Yes, the image_loader abstraction in this series is essentially the
> main-U-Boot equivalent of SPL's spl_load_info.read(), adapted for the
> richer set of storage backends, byte-addressed, providing an interface
> for both "load this to where ever" and "load this to a specific target
> address" (image_loader_map() vs. image_loader_map_to()), and the full
> fit_image_load() verification pipeline. The integration point in
> fit_image_load() (patch 09/20) is ~50 lines of new code gated by if
> (images->loader && external_data) - it reuses all existing FIT property
> parsing, load address negotiation, and hash verification unchanged.
> 
> That said, the image_loader abstraction itself is format-agnostic - it
> only deals with byte offsets, lengths, and RAM destinations. The same
> three storage backends could be wired into other executable formats with
> minimal effort, such as ELF, legacy uImage or UEFI PE.
> 
> Likewise, adding a backend based on fs_read() would be trivial,
> extending U-Boot's wget to support range requests and using it as
> image_loader backend would not be hard either.
> 
>> Can that SPL code be reused instead ?
> 
> I considered factoring out a shared "FIT external data reader" between
> SPL and U-Boot proper, but the two callers want fundamentally different
> things: SPL wants minimal code size and populates spl_image_info; U-Boot
> proper wants full verification and populates bootm_headers.

I suspect the feature set of each loading stage can be configured e.g. 
using "if (IS_ENABLED(...))" to keep the size under control ?

I would be very happy if we could have ONE consistent code base used for 
loading in all of TPL/SPL/U-Boot . Custom special loader in U-Boot and 
different special loader in SPL and so on, will only lead to 
inconsistency and increased maintenance burden. Worse, it will lead to 
obscure bugs which will differ between U-Boot and SPL, or bugs being 
fixed in one and not the other.
