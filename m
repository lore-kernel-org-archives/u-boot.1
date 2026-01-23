Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6B3D72367
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 10:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC2A83B03;
	Fri, 23 Jan 2026 11:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="S4I2RmxR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wE+W6Pk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3BA83B0B; Fri, 23 Jan 2026 11:27:51 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD2183AC5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 11:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dyDdw58xbz9t3C;
 Fri, 23 Jan 2026 11:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769164068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJROupKTeEYwIMfUbPGFuQTAryZcwPaaBNBFhqedkss=;
 b=S4I2RmxRm3bkTkE/6GDeVv7pw158dCWrzh49Hy2dsnz+4g13KvaFrY15UfNxveVF5WAHd6
 lv9etainz9GoCG2kDwC7+n6LCM9OpUwvf8cm09YIMEp6Duc88nUHY4fbe24vVSIODiAaJi
 /SJZ6pd4mrz7U4EyRtAmx7nnjQiwigK/yNraPQlUvkA/aXdJyy6b45/4p2kKjkZaxdvfrz
 V96cLuh7RH8AxQfm7eY1X7f9GrSICaP/8iTf9bhrO7oAE9JQFSdE3CcllCwzHk9YC7w5rz
 ThziFSPgg4+uzZNQFAk6QOGfZknH3jvvb5fzQWXKJQsoHfiYbyfrStT4Y9FRYw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="wE+W6Pk/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769164066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJROupKTeEYwIMfUbPGFuQTAryZcwPaaBNBFhqedkss=;
 b=wE+W6Pk/LJgr+f5pt6nGiei3jqIJYsl5vilnujKePhLs55WiUxu4dokSDJgIJY08Bymk72
 WOWBiDJWtSVmznhlolY7v1RnzJ/eXtMffXDQzdSzy7rCixXmDaqbGVJxZdvYJjsFnnGy7/
 H970T8QKniGyRJBWWMSwgUCG93UVJTu5P+qX1KHnRnlz9+nFtD39JHWnVDrFuk89e0a1ak
 TIsOLTxaaldZ/2HFXh8KMX18onXFCqqrbylAB8k6SjBbQE5+exUuYR9ntTDMJTjJ/gSZpN
 sGTcz6Tdk7P6vjavnRi2JpRvSxPL06QdnIGmf1Y4LsuHgYQPBvijTEIiYsWMDw==
Date: Fri, 23 Jan 2026 11:27:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Beleswar Prasad Padhi <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1fbyc4pndzs8s8ytnynbcgigr11tcgoz
X-MBO-RS-ID: 3e9839bcbf37c6cc9c2
X-Rspamd-Queue-Id: 4dyDdw58xbz9t3C
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

On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
> 
> On 23/01/26 00:33, Marek Vasut wrote:
>> On 1/22/26 6:45 PM, Tom Rini wrote:
>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>>
>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>>>
>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>>> setup_multi_dtb_fit() when locating the next available DTB within the
>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>>>> version v1.7.2-35-g52f07dcca47c")
>>>>
>>>> The mkimage tool already supports enforcing this alignment via the -B
>>>> option, but users would have to specify it explicitly. This change
>>>> makes 8-byte alignment the default when using -b.
>>>>
>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>
>>> Tested-by: Tom Rini <trini@konsulko.com>
>> Doesn't this enable 8-byte alignment for everything in case a DT is specified on mkimage command line ? That doesn't seem right ?
>>
>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
> 
> 
> All the mkimage flags are parsed at once and populated in the params
> data structure in one shot in the code. There is no separation of code
> specifically for generating a FIT for a DTB vs for anything else.

That does not seem to be true ?

$ git grep -p '\<bl_len\>' tools/
tools/fit_image.c=static int fit_extract_data(struct image_tool_params 
*params, const char *fname)
tools/fit_image.c:      align_size = params->bl_len ? params->bl_len : 4;
...

So something like that may work ?

"
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 0306333141e..0c606ba4cc3 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -642,9 +642,15 @@ static int fit_extract_data(struct 
image_tool_params *params, const char *fname)
         for (node = fdt_first_subnode(fdt, images);
              node >= 0;
              node = fdt_next_subnode(fdt, node)) {
-               const char *data;
+               const char *data, *type;
                 int len;

+               if (align_size < 8) {
+                       type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
+                       if (type && !strcmp(type, "flat_dt"))
+                               align_size = 8;
+               }
+
                 data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
                 if (!data)
                         continue;
"

> We
> would get the same result when using mkimage -f auto -b ...dtb... -B 0x8
> I think we should be fine with this limitation for the usecases when
> generating fitImage with mixed images. Unless you have some idea?
What about the above ?
