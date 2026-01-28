Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E04D3F083
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 17:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A8F84034;
	Wed, 28 Jan 2026 18:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ay8N9r0j";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mBBJU+ky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B661284099; Wed, 28 Jan 2026 18:23:31 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CC58401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 18:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1TdD5bfMz9vBj;
 Wed, 28 Jan 2026 18:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769621008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t/vGypjmFrWK2ZZQSkJyW88o3QUL0LwSenYfEI0HFQA=;
 b=Ay8N9r0jm95zpMEmoZg1ETiVAIkHBPNAwpMoYRaqFDQb6/jAfJRu4BS9CXBs5Ygi/8ZPQW
 mDz5oNeJbXTRFN7nc8/4PLGW4+0+3RUvd5R7mTo3UUDk688xAECo4sNB2FbMeheM3XDn2o
 O3fI9t6wsttY6LemEKzdvZENb0mVkxx6/Gm/jSWdn385X+Du7aL4+nSNcX3BTxDTRRJUS1
 2wrakhDK28bIIC31FwCraN5hUIN2/vTTv1QLt+T/72Lw5XtEuw8LDx1jTg5xKDqqu5pwPa
 LZDVQwFHfnkdRwd9tqFTzliZNgDkByZeXLkTjeTwSg73/i31jeItD2C0U3lATg==
Content-Type: multipart/mixed; boundary="------------V7bBwJLp0dXctZ3JHhXhMp0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769621006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t/vGypjmFrWK2ZZQSkJyW88o3QUL0LwSenYfEI0HFQA=;
 b=mBBJU+kygz2Nsq6YOS+RPP7XlUUpHdvyrcry3W2aecZQIvCYjDDlYJVQPba/ZZHepnhZPy
 VbcvT107lpfb3Ryzh8Z4LgrfesrOnlQuZHd9lKXC8WjWwyPC49/cHqUNmLP6PkNwykzR4l
 +DZpreVZ+bx5pThOKvvPyUQA4ZXDrzgE/nOlHIJBQf3Y99HDeNcpnEECm2iuShUVGq+jGZ
 jEuqyKX1aTe7RbxCTMt24bVlYexkXucL1KrFz8+TOyOqG4RUM1WIkIBqHJIU+38ykMh/8E
 qHWEiCkQjrer8R7IT+QC5dzEoKL6TdDalJ9wqK9GqBiDvXeMCjZvC6CigAU3mw==
Message-ID: <3432c5f4-ad37-46fe-bac3-ec0fc7778767@mailbox.org>
Date: Wed, 28 Jan 2026 18:23:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
To: Sean Anderson <seanga2@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
 trini@konsulko.com
Cc: sean.anderson@seco.com, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260128141834.2322865-1-b-padhi@ti.com>
 <708253cc-be1d-f375-0427-91658d5e88fe@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <708253cc-be1d-f375-0427-91658d5e88fe@gmail.com>
X-MBO-RS-ID: c4bbc8b96ee662d2c78
X-MBO-RS-META: 5skyy5acs33sjezzy837eurb3bpc75bm
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

This is a multi-part message in MIME format.
--------------V7bBwJLp0dXctZ3JHhXhMp0G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/26 5:48 PM, Sean Anderson wrote:
> Hi Beleswar,
> 
> On 1/28/26 09:18, Beleswar Padhi wrote:
>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>> packed inside the multidtb.fit FIT image. While the individual DTBs
>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>
>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>> setup_multi_dtb_fit() when locating the next available DTB within the
>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>> version v1.7.2-35-g52f07dcca47c")
>>
>> To fix this, check the image type when extracting FIT image data and
>> set the alignment size to 8 bytes (if not already) only for flat_dt
>> images. This ensures correct alignment for device tree blobs as per the
>> DT spec, while also allowing different alignment sizes for other image
>> types within the FIT.
>>
>> Reported-by: Anshul Dalal <anshuld@ti.com>
>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version 
>> v1.7.2-35-g52f07dcca47c")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> Testing Done:
>> 1. Boot tested on all TI K3 platforms.
>>
>> v4: Changelog:
>> 1. Align only the DTBs to 8-bytes, other images in a FIT can have their
>>     independent alignment. [Marek]
>>
>> Link to v3:
>> https://lore.kernel.org/all/20260122172247.2995437-1-b-padhi@ti.com/
>>
>> v3: Changelog:
>> 1. Default to 8-byte alignment for DTBs in mkimage instead of
>>     passing -B 0x8 in build command [Marek]
>> 2. Remove previous R/Bs.
>>
>> Link to v2:
>> https://lore.kernel.org/all/20260112101102.1417970-2-b-padhi@ti.com/
>>
>> v2: Changelog:
>> 1. Carry R/B, Reported-by, Closes and Fixes tag.
>>
>> Link to v1:
>> https://lore.kernel.org/all/20260109190026.58464-2-b-padhi@ti.com/
>>
>>   tools/fit_image.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Can you please update doc/mkimage.1 as well? There should be a note about
> this under -E.
> 
>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>> index e865f65a400..f842c845771 100644
>> --- a/tools/fit_image.c
>> +++ b/tools/fit_image.c
>> @@ -682,9 +682,17 @@ static int fit_extract_data(struct 
>> image_tool_params *params, const char *fname)
>>       for (node = fdt_first_subnode(fdt, images);
>>            node >= 0;
>>            node = fdt_next_subnode(fdt, node)) {
>> -        const char *data;
>> +        const char *data, *type;
>>           int len;
>> +        /* Fallback to 8-byte alignment for DTBs if unaligned */
>> +        type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
>> +        if (type &&
>> +            len == sizeof("flat_dt") &&
>> +            !memcmp(type, "flat_dt", len) &&
>> +            align_size & 0x7)
>> +            align_size = 8;
>> +
> 
> Doesn't this increase the alignment for all images following the 
> devicetree?
> 
> And actually, doesn't this happen too late? By the time we check whether 
> the
> node is a devicetree, buf_ptr has already been updated. This check will 
> only
> affect the alignment of the *next* image in the FIT.
How about we turn this around this way, add up the alignments first to 
deal with allocation, and then fiddle with the buf_ptr based on the 
previous iteration to layout the images ?

diff --git a/tools/fit_image.c b/tools/fit_image.c
index e865f65a400..82ffd03c288 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -651,10 +651,9 @@ static int fit_extract_data(struct 
image_tool_params *params, const char *fname)
  	int ret;
  	int images;
  	int node;
-	int image_number;
-	int align_size;
+	int align_size = 0;
+	int len = 0;

-	align_size = params->bl_len ? params->bl_len : 4;
  	fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
  	if (fd < 0)
  		return -EIO;
@@ -666,24 +665,54 @@ static int fit_extract_data(struct 
image_tool_params *params, const char *fname)
  		ret = -EINVAL;
  		goto err_munmap;
  	}
-	image_number = fdtdec_get_child_count(fdt, images);
+
+	/* Add up all the alignments, we no longer need to count images. */
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *type;
+		int len;
+
+		if (params->bl_len) {
+			align_size += params->bl_len;
+			continue;
+		}
+
+		type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
+		if (type && len == sizeof("flat_dt") && !memcmp(type, "flat_dt", len)) {
+			align_size += 8; // or params->bl_len rounded up to 8 ?
+			continue;
+		}
+
+		/* Default alignment to 4 Bytes */
+		align_size += 4;
+	}

  	/*
  	 * Allocate space to hold the image data we will extract,
  	 * extral space allocate for image alignment to prevent overflow.
  	 */
-	buf = calloc(1, fit_size + (align_size * image_number));
+	buf = calloc(1, fit_size + align_size);
  	if (!buf) {
  		ret = -ENOMEM;
  		goto err_munmap;
  	}
  	buf_ptr = 0;

-	for (node = fdt_first_subnode(fdt, images);
-	     node >= 0;
-	     node = fdt_next_subnode(fdt, node)) {
-		const char *data;
-		int len;
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *data, *type;
+		int pl;
+
+		if (params->bl_len)
+			align_size = 8;//params->bl_len;
+		else {
+			type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &pl);
+			if (type && pl == sizeof("flat_dt") && !memcmp(type, "flat_dt", pl))
+				align_size = 8; // or params->bl_len rounded up to 8 ?
+			else	/* Default alignment to 4 Bytes */
+				align_size = 8;
+		}
+
+		/* len is 0 in first round, else comes from previous round. */
+		buf_ptr += ALIGN(len, align_size);

  		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
  		if (!data)
@@ -716,10 +745,11 @@ static int fit_extract_data(struct 
image_tool_params *params, const char *fname)
  			ret = -EINVAL;
  			goto err_munmap;
  		}
-
-		buf_ptr += ALIGN(len, align_size);
  	}

+	/* comes from previous round. */
+	buf_ptr += ALIGN(len, align_size);
+
  	/* Pack the FDT and place the data after it */
  	fdt_pack(fdt);

--
--------------V7bBwJLp0dXctZ3JHhXhMp0G
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tools-fit_image-Fallback-to-8-byte-alignment-for-fla.patch"
Content-Disposition: attachment;
 filename*0="0001-tools-fit_image-Fallback-to-8-byte-alignment-for-fla.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3MTQ5ZDEwNTIzMzJiNTUyNDJlNTQyOGFiNzYyYjZlMjBhNjA3NzllIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNh
c0BtYWlsYm94Lm9yZz4KRGF0ZTogV2VkLCAyOCBKYW4gMjAyNiAxOTo0ODozNCArMDUzMApT
dWJqZWN0OiBbUEFUQ0hdIHRvb2xzOiBmaXRfaW1hZ2U6IEZhbGxiYWNrIHRvIDgtYnl0ZSBh
bGlnbm1lbnQgZm9yIGZsYXRfZHQKIGltYWdlcwoKV2hlbiBDT05GSUdfU1BMX01VTFRJX0RU
Ql9GSVQgaXMgZW5hYmxlZCwgbXVsdGlwbGUgZGV2aWNlIHRyZWVzIGFyZQpwYWNrZWQgaW5z
aWRlIHRoZSBtdWx0aWR0Yi5maXQgRklUIGltYWdlLiBXaGlsZSB0aGUgaW5kaXZpZHVhbCBE
VEJzCmFuZCB0aGUgRklUIGltYWdlIHN0YXJ0IGFkZHJlc3MgYXJlIDgtYnl0ZSBhbGlnbmVk
LCB0aGUgRFRCcyBlbWJlZGRlZAp3aXRoaW4gdGhlIEZJVCBpbWFnZSBhcmUgbm90IGd1YXJh
bnRlZWQgdG8gbWFpbnRhaW4gOC1ieXRlIGFsaWdubWVudC4KClRoaXMgbWlzYWxpZ25tZW50
IGNhdXNlcyAtRkRUX0VSUl9BTElHTk1FTlQgZmFpbHVyZSBpbgpzZXR1cF9tdWx0aV9kdGJf
Zml0KCkgd2hlbiBsb2NhdGluZyB0aGUgbmV4dCBhdmFpbGFibGUgRFRCIHdpdGhpbiB0aGUK
RklUIGJsb2IgYW5kIHNldHRpbmcgZ2QtPmZkdF9ibG9iLCBiZWNhdXNlIG9mIHRoZSByZWNl
bnQgbGliZmR0CmhhcmRlbmluZyBzaW5jZSBjb21taXQgMDUzNWU0NmQ1NWQ3ICgic2NyaXB0
cy9kdGM6IFVwZGF0ZSB0byB1cHN0cmVhbQp2ZXJzaW9uIHYxLjcuMi0zNS1nNTJmMDdkY2Nh
NDdjIikKClRvIGZpeCB0aGlzLCBjaGVjayB0aGUgaW1hZ2UgdHlwZSB3aGVuIGV4dHJhY3Rp
bmcgRklUIGltYWdlIGRhdGEgYW5kCnNldCB0aGUgYWxpZ25tZW50IHNpemUgdG8gOCBieXRl
cyAoaWYgbm90IGFscmVhZHkpIG9ubHkgZm9yIGZsYXRfZHQKaW1hZ2VzLiBUaGlzIGVuc3Vy
ZXMgY29ycmVjdCBhbGlnbm1lbnQgZm9yIGRldmljZSB0cmVlIGJsb2JzIGFzIHBlciB0aGUK
RFQgc3BlYywgd2hpbGUgYWxzbyBhbGxvd2luZyBkaWZmZXJlbnQgYWxpZ25tZW50IHNpemVz
IGZvciBvdGhlciBpbWFnZQp0eXBlcyB3aXRoaW4gdGhlIEZJVC4KClJlcG9ydGVkLWJ5OiBB
bnNodWwgRGFsYWwgPGFuc2h1bGRAdGkuY29tPgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3UtYm9vdC9ERko5NTBPMFFNMEQuMzgwVTBOMTZaTzE5RUB0aS5jb20KRml4ZXM6
IDA1MzVlNDZkNTVkNyAoInNjcmlwdHMvZHRjOiBVcGRhdGUgdG8gdXBzdHJlYW0gdmVyc2lv
biB2MS43LjItMzUtZzUyZjA3ZGNjYTQ3YyIpClNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0
IDxtYXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPgpTaWduZWQtb2ZmLWJ5OiBCZWxl
c3dhciBQYWRoaSA8Yi1wYWRoaUB0aS5jb20+Ci0tLQogdG9vbHMvZml0X2ltYWdlLmMgfCA1
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3Rvb2xzL2ZpdF9pbWFnZS5jIGIvdG9vbHMvZml0X2ltYWdlLmMKaW5kZXggZTg2
NWY2NWE0MDAuLjgyZmZkMDNjMjg4IDEwMDY0NAotLS0gYS90b29scy9maXRfaW1hZ2UuYwor
KysgYi90b29scy9maXRfaW1hZ2UuYwpAQCAtNjUxLDEwICs2NTEsOSBAQCBzdGF0aWMgaW50
IGZpdF9leHRyYWN0X2RhdGEoc3RydWN0IGltYWdlX3Rvb2xfcGFyYW1zICpwYXJhbXMsIGNv
bnN0IGNoYXIgKmZuYW1lKQogCWludCByZXQ7CiAJaW50IGltYWdlczsKIAlpbnQgbm9kZTsK
LQlpbnQgaW1hZ2VfbnVtYmVyOwotCWludCBhbGlnbl9zaXplOworCWludCBhbGlnbl9zaXpl
ID0gMDsKKwlpbnQgbGVuID0gMDsKIAotCWFsaWduX3NpemUgPSBwYXJhbXMtPmJsX2xlbiA/
IHBhcmFtcy0+YmxfbGVuIDogNDsKIAlmZCA9IG1tYXBfZmR0KHBhcmFtcy0+Y21kbmFtZSwg
Zm5hbWUsIDAsICZmZHQsICZzYnVmLCBmYWxzZSwgZmFsc2UpOwogCWlmIChmZCA8IDApCiAJ
CXJldHVybiAtRUlPOwpAQCAtNjY2LDI0ICs2NjUsNTQgQEAgc3RhdGljIGludCBmaXRfZXh0
cmFjdF9kYXRhKHN0cnVjdCBpbWFnZV90b29sX3BhcmFtcyAqcGFyYW1zLCBjb25zdCBjaGFy
ICpmbmFtZSkKIAkJcmV0ID0gLUVJTlZBTDsKIAkJZ290byBlcnJfbXVubWFwOwogCX0KLQlp
bWFnZV9udW1iZXIgPSBmZHRkZWNfZ2V0X2NoaWxkX2NvdW50KGZkdCwgaW1hZ2VzKTsKKwor
CS8qIEFkZCB1cCBhbGwgdGhlIGFsaWdubWVudHMsIHdlIG5vIGxvbmdlciBuZWVkIHRvIGNv
dW50IGltYWdlcy4gKi8KKwlmZHRfZm9yX2VhY2hfc3Vibm9kZShub2RlLCBmZHQsIGltYWdl
cykgeworCQljb25zdCBjaGFyICp0eXBlOworCQlpbnQgbGVuOworCisJCWlmIChwYXJhbXMt
PmJsX2xlbikgeworCQkJYWxpZ25fc2l6ZSArPSBwYXJhbXMtPmJsX2xlbjsKKwkJCWNvbnRp
bnVlOworCQl9CisKKwkJdHlwZSA9IGZkdF9nZXRwcm9wKGZkdCwgbm9kZSwgRklUX1RZUEVf
UFJPUCwgJmxlbik7CisJCWlmICh0eXBlICYmIGxlbiA9PSBzaXplb2YoImZsYXRfZHQiKSAm
JiAhbWVtY21wKHR5cGUsICJmbGF0X2R0IiwgbGVuKSkgeworCQkJYWxpZ25fc2l6ZSArPSA4
OyAvLyBvciBwYXJhbXMtPmJsX2xlbiByb3VuZGVkIHVwIHRvIDggPworCQkJY29udGludWU7
CisJCX0KKworCQkvKiBEZWZhdWx0IGFsaWdubWVudCB0byA0IEJ5dGVzICovCisJCWFsaWdu
X3NpemUgKz0gNDsKKwl9CiAKIAkvKgogCSAqIEFsbG9jYXRlIHNwYWNlIHRvIGhvbGQgdGhl
IGltYWdlIGRhdGEgd2Ugd2lsbCBleHRyYWN0LAogCSAqIGV4dHJhbCBzcGFjZSBhbGxvY2F0
ZSBmb3IgaW1hZ2UgYWxpZ25tZW50IHRvIHByZXZlbnQgb3ZlcmZsb3cuCiAJICovCi0JYnVm
ID0gY2FsbG9jKDEsIGZpdF9zaXplICsgKGFsaWduX3NpemUgKiBpbWFnZV9udW1iZXIpKTsK
KwlidWYgPSBjYWxsb2MoMSwgZml0X3NpemUgKyBhbGlnbl9zaXplKTsKIAlpZiAoIWJ1Zikg
ewogCQlyZXQgPSAtRU5PTUVNOwogCQlnb3RvIGVycl9tdW5tYXA7CiAJfQogCWJ1Zl9wdHIg
PSAwOwogCi0JZm9yIChub2RlID0gZmR0X2ZpcnN0X3N1Ym5vZGUoZmR0LCBpbWFnZXMpOwot
CSAgICAgbm9kZSA+PSAwOwotCSAgICAgbm9kZSA9IGZkdF9uZXh0X3N1Ym5vZGUoZmR0LCBu
b2RlKSkgewotCQljb25zdCBjaGFyICpkYXRhOwotCQlpbnQgbGVuOworCWZkdF9mb3JfZWFj
aF9zdWJub2RlKG5vZGUsIGZkdCwgaW1hZ2VzKSB7CisJCWNvbnN0IGNoYXIgKmRhdGEsICp0
eXBlOworCQlpbnQgcGw7CisKKwkJaWYgKHBhcmFtcy0+YmxfbGVuKQorCQkJYWxpZ25fc2l6
ZSA9IDg7Ly9wYXJhbXMtPmJsX2xlbjsKKwkJZWxzZSB7CisJCQl0eXBlID0gZmR0X2dldHBy
b3AoZmR0LCBub2RlLCBGSVRfVFlQRV9QUk9QLCAmcGwpOworCQkJaWYgKHR5cGUgJiYgcGwg
PT0gc2l6ZW9mKCJmbGF0X2R0IikgJiYgIW1lbWNtcCh0eXBlLCAiZmxhdF9kdCIsIHBsKSkK
KwkJCQlhbGlnbl9zaXplID0gODsgLy8gb3IgcGFyYW1zLT5ibF9sZW4gcm91bmRlZCB1cCB0
byA4ID8KKwkJCWVsc2UJLyogRGVmYXVsdCBhbGlnbm1lbnQgdG8gNCBCeXRlcyAqLworCQkJ
CWFsaWduX3NpemUgPSA4OworCQl9CisKKwkJLyogbGVuIGlzIDAgaW4gZmlyc3Qgcm91bmQs
IGVsc2UgY29tZXMgZnJvbSBwcmV2aW91cyByb3VuZC4gKi8KKwkJYnVmX3B0ciArPSBBTElH
TihsZW4sIGFsaWduX3NpemUpOwogCiAJCWRhdGEgPSBmZHRfZ2V0cHJvcChmZHQsIG5vZGUs
IEZJVF9EQVRBX1BST1AsICZsZW4pOwogCQlpZiAoIWRhdGEpCkBAIC03MTYsMTAgKzc0NSwx
MSBAQCBzdGF0aWMgaW50IGZpdF9leHRyYWN0X2RhdGEoc3RydWN0IGltYWdlX3Rvb2xfcGFy
YW1zICpwYXJhbXMsIGNvbnN0IGNoYXIgKmZuYW1lKQogCQkJcmV0ID0gLUVJTlZBTDsKIAkJ
CWdvdG8gZXJyX211bm1hcDsKIAkJfQotCi0JCWJ1Zl9wdHIgKz0gQUxJR04obGVuLCBhbGln
bl9zaXplKTsKIAl9CiAKKwkvKiBjb21lcyBmcm9tIHByZXZpb3VzIHJvdW5kLiAqLworCWJ1
Zl9wdHIgKz0gQUxJR04obGVuLCBhbGlnbl9zaXplKTsKKwogCS8qIFBhY2sgdGhlIEZEVCBh
bmQgcGxhY2UgdGhlIGRhdGEgYWZ0ZXIgaXQgKi8KIAlmZHRfcGFjayhmZHQpOwogCi0tIAoy
LjUxLjAKCg==

--------------V7bBwJLp0dXctZ3JHhXhMp0G--
