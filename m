Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C501D1171E
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 17:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6C183EAF;
	Tue,  2 Dec 2025 18:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HYcLuaYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387DC83EB3; Tue,  2 Dec 2025 18:46:16 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EC283EA6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 18:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dLSqk4vTyz9thl;
 Tue,  2 Dec 2025 18:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764697570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hOVW/SlcLnJdblnWTy2SuqjdDZj9/uoIGmRrw1c/A1k=;
 b=HYcLuaYYKF7slMgBBUeKm8VDGnsBaAtNKSyk2XAr2PR+vJlmrqLEtQpqMtRL75LiKItqbb
 6eUfy2StyZUFdew5KzJYOzAQFD5OsWoIkI4lrnLnAOcBHK6DGgbNctg0VF2qlcPQcP9/Kk
 M4VwSFkVDjUaOx5WBqIL0+Apedf8ZIQ//uLJaTPLjxD4MYRwK4ZaSt1tLTvs3qdkR8k5mt
 JuizJdcoluw5YgKldV2xMRva2ABt+BIsFy246GFgnKbjF4/L1outST/IEEhZGGgFxWfOwU
 3I649dH5iBKSI4jFc4WV8pgoUJ1WeH7cik4811El0k6Y2JEM78Gl+l3eumTh1w==
Content-Type: multipart/mixed; boundary="------------zr6CbVGQWX6RisOJb43HEyES"
Message-ID: <6daeb492-0c5f-433d-b4f5-56ad5ca1704d@mailbox.org>
Date: Tue, 2 Dec 2025 18:46:07 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat> <20251121195512.GE2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251121195512.GE2125796@bill-the-cat>
X-MBO-RS-ID: 3dcd2786a5bb356b9da
X-MBO-RS-META: 8iks3o4f5mk6xj5azaqb6r47ikfrc1n9
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
--------------zr6CbVGQWX6RisOJb43HEyES
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 8:55 PM, Tom Rini wrote:

Hello Tom,

>>> Synchronize local copy of DTC with Linux 6.17 , using commits picked
>>> from Linux kernel. This also includes two fix up patches to make the
>>> DM core work with new 8-byte alignment checking in libfdt and another
>>> fix for NULL pointer check that is missing in libfdt.
>>>
>>> This depends on the following patches sent separately, which fix
>>> various 8-byte alignment problems in the code base:
>>>
>>>   - boot: android: Always use 8-byte aligned DT with libfdt
>>>   - test/py: android: Point fdt command to aligned addresses
>>>   - test/py: Use aligned address for overlays in 'extension' test
>>>   - sandbox: Fix DT compiler address warnings in sandbox DTs
>>>   - sandbox: Fix DT compiler pin warnings in sandbox DTs
>>>   - boot: Assure FDT is always at 8-byte aligned address
>>>   - arm: qemu: Eliminate fdt_high and initrd_high misuse
>>>   - efi_loader: Assure fitImage from capsule is used from 8-byte aligned address
>>>   - MIPS: Assure end of U-Boot is at 8-byte aligned offset
>>
>> So, taking a look at the test branch you pointed me at, my big concern
>> is size growth. On imx8mp_dhcom_drc02 (where we're already LTO'ing),
>> with the CI gcc-14.2.0 toolchain full U-Boot grows by more than 6KiB and
>> SPL by a bit more than 2KiB. This is a bit of a worst-case, imx8mp_navqp
>> is a bit more than 3KiB / 548 bytes, with the average feeling like
>> ~4KiB/1KiB for aarch64.
> 
> I'm coming back to this to try and better understand things. And one
> problem here is that upstream dtc changes really trip up LTO. I made as
> a local hack, a change for imx8mp_dhcom_pdk2 to NOT use LTO (and so SPL
> fails to link, but it's about the same growth, given the change in
> overflows sram by numbers). This brought the size change down from ~6KiB
> to ~4KiB.  Since this was already a hack just for investigation, I then
> started out with giving full U-Boot the "assume perfect dtb" mask. This
> reduces growth by 900 bytes.
> 
> A better test case is pinephone because it's aarch64 but not LTO. And
> with a full mask in U-Boot hack, the size growth for full U-Boot is
> around 1000 bytes and 300 bytes in SPL.
> 
> And so to me, there's a few questions. The first of which is, how is
> what's being done so terrible for LTO. It's not good for normal
> optimizations either, but it's really bad with LTO. The second of which
> is, is there something being done with how the sanity checks are
> performed that can be re-examined? Take fdt_get_string for example,
> which grows by 120 bytes without changing the mask at all, and the code
> changes are trivial switches to the new FDT_ASSUME mechanic and dropping
> extra parens. That shouldn't have size growth, I would expect.

Does this patch below make your size problem go away ?

"
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index d7cf74722b2..7f8bb05c545 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -140,12 +140,7 @@ static inline uint16_t fdt16_ld(const fdt16_t *p)

  static inline uint32_t fdt32_ld(const fdt32_t *p)
  {
-	const uint8_t *bp = (const uint8_t *)p;
-
-	return ((uint32_t)bp[0] << 24)
-		| ((uint32_t)bp[1] << 16)
-		| ((uint32_t)bp[2] << 8)
-		| bp[3];
+	return fdt32_to_cpu(*p);
  }

  static inline void fdt32_st(void *property, uint32_t value)
@@ -160,16 +155,7 @@ static inline void fdt32_st(void *property, 
uint32_t value)

  static inline uint64_t fdt64_ld(const fdt64_t *p)
  {
-	const uint8_t *bp = (const uint8_t *)p;
-
-	return ((uint64_t)bp[0] << 56)
-		| ((uint64_t)bp[1] << 48)
-		| ((uint64_t)bp[2] << 40)
-		| ((uint64_t)bp[3] << 32)
-		| ((uint64_t)bp[4] << 24)
-		| ((uint64_t)bp[5] << 16)
-		| ((uint64_t)bp[6] << 8)
-		| bp[7];
+	return fdt64_to_cpu(*p);
  }

  static inline void fdt64_st(void *property, uint64_t value)
"

You can see the difference caused by these new unaligned-access 
functions in the disassembly (objdump -lSD) of u-boot with (top) and 
without (bottom) the DTC 1.7.2 patch:

"
00000000402984e0 <fdt_get_string>:
fdt_get_string():
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:35
{
     402984e0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
     402984e4:   aa0003e3        mov     x3, x0
     402984e8:   2a0103e4        mov     w4, w1
     402984ec:   910003fd        mov     x29, sp
     402984f0:   a90153f3        stp     x19, x20, [sp, #16]
     402984f4:   aa0203f4        mov     x20, x2
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:49
         totalsize = fdt_ro_probe_(fdt);
     402984f8:   97fffe4b        bl      40297e24 <fdt_ro_probe_>
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:51
         if (totalsize < 0)
     402984fc:   37f80a40        tbnz    w0, #31, 40298644 
<fdt_get_string+0x164>
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #1
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55
         absoffset = stroffset + fdt_off_dt_strings(fdt);
     40298500:   39403061        ldrb    w1, [x3, #12]
     40298504:   39403462        ldrb    w2, [x3, #13]
     40298508:   39403c73        ldrb    w19, [x3, #15]
     4029850c:   aa022022        orr     x2, x1, x2, lsl #8
     40298510:   39403861        ldrb    w1, [x3, #14]
     40298514:   aa014041        orr     x1, x2, x1, lsl #16
     40298518:   aa136033        orr     x19, x1, x19, lsl #24
     4029851c:   5ac00a73        rev     w19, w19
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #1
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55 
(discriminator 1)
     40298520:   0b130093        add     w19, w4, w19
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:56
         if (absoffset >= (unsigned)totalsize)
     40298524:   6b13001f        cmp     w0, w19
     40298528:   54000969        b.ls    40298654 <fdt_get_string+0x174> 
  // b.plast
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:58
         len = totalsize - absoffset;
     4029852c:   39400062        ldrb    w2, [x3]
     40298530:   4b130000        sub     w0, w0, w19
/tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:60
         if (fdt_magic(fdt) == FDT_MAGIC) {
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #2
     40298534:   39400461        ldrb    w1, [x3, #1]
     40298538:   aa012041        orr     x1, x2, x1, lsl #8
     4029853c:   39400862        ldrb    w2, [x3, #2]
     40298540:   aa024022        orr     x2, x1, x2, lsl #16
     40298544:   39400c61        ldrb    w1, [x3, #3]
     40298548:   aa016041        orr     x1, x2, x1, lsl #24
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #2
"

"
0000000040297804 <fdt_get_string>:
fdt_get_string():
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:35
{
     40297804:   a9bd7bfd        stp     x29, x30, [sp, #-48]!
     40297808:   910003fd        mov     x29, sp
     4029780c:   a90153f3        stp     x19, x20, [sp, #16]
     40297810:   2a0103f4        mov     w20, w1
     40297814:   a9025bf5        stp     x21, x22, [sp, #32]
     40297818:   aa0003f6        mov     x22, x0
     4029781c:   aa0203f5        mov     x21, x2
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:49
         totalsize = fdt_ro_probe_(fdt);
     40297820:   97fff833        bl      402958ec <fdt_ro_probe_>
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:51
         if (totalsize < 0)
     40297824:   37f806a0        tbnz    w0, #31, 402978f8 
<fdt_get_string+0xf4>
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55
         absoffset = stroffset + fdt_off_dt_strings(fdt);
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #1
     40297828:   b9400ed3        ldr     w19, [x22, #12]
     4029782c:   5ac00a73        rev     w19, w19
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #1
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55 
(discriminator 6)
     40297830:   0b130293        add     w19, w20, w19
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:56
         if (absoffset >= (unsigned)totalsize)
     40297834:   6b13001f        cmp     w0, w19
     40297838:   54000689        b.ls    40297908 <fdt_get_string+0x104> 
  // b.plast
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:58
         len = totalsize - absoffset;
     4029783c:   b94002c1        ldr     w1, [x22]
/tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:60 
(discriminator 6)
         if (fdt_magic(fdt) == FDT_MAGIC) {
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #2
     40297840:   5281ba02        mov     w2, #0xdd0 
// #3536
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #2
"

But the question now is, how should we handle this ? These unaligned 
access functions are there for a reason.
--------------zr6CbVGQWX6RisOJb43HEyES
Content-Type: text/x-patch; charset=UTF-8; name="fdt.diff"
Content-Disposition: attachment; filename="fdt.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NjcmlwdHMvZHRjL2xpYmZkdC9saWJmZHQuaCBiL3NjcmlwdHMvZHRj
L2xpYmZkdC9saWJmZHQuaAppbmRleCBkN2NmNzQ3MjJiMi4uN2Y4YmIwNWM1NDUgMTAwNjQ0
Ci0tLSBhL3NjcmlwdHMvZHRjL2xpYmZkdC9saWJmZHQuaAorKysgYi9zY3JpcHRzL2R0Yy9s
aWJmZHQvbGliZmR0LmgKQEAgLTE0MCwxMiArMTQwLDcgQEAgc3RhdGljIGlubGluZSB1aW50
MTZfdCBmZHQxNl9sZChjb25zdCBmZHQxNl90ICpwKQogCiBzdGF0aWMgaW5saW5lIHVpbnQz
Ml90IGZkdDMyX2xkKGNvbnN0IGZkdDMyX3QgKnApCiB7Ci0JY29uc3QgdWludDhfdCAqYnAg
PSAoY29uc3QgdWludDhfdCAqKXA7Ci0KLQlyZXR1cm4gKCh1aW50MzJfdClicFswXSA8PCAy
NCkKLQkJfCAoKHVpbnQzMl90KWJwWzFdIDw8IDE2KQotCQl8ICgodWludDMyX3QpYnBbMl0g
PDwgOCkKLQkJfCBicFszXTsKKwlyZXR1cm4gZmR0MzJfdG9fY3B1KCpwKTsKIH0KIAogc3Rh
dGljIGlubGluZSB2b2lkIGZkdDMyX3N0KHZvaWQgKnByb3BlcnR5LCB1aW50MzJfdCB2YWx1
ZSkKQEAgLTE2MCwxNiArMTU1LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGZkdDMyX3N0KHZv
aWQgKnByb3BlcnR5LCB1aW50MzJfdCB2YWx1ZSkKIAogc3RhdGljIGlubGluZSB1aW50NjRf
dCBmZHQ2NF9sZChjb25zdCBmZHQ2NF90ICpwKQogewotCWNvbnN0IHVpbnQ4X3QgKmJwID0g
KGNvbnN0IHVpbnQ4X3QgKilwOwotCi0JcmV0dXJuICgodWludDY0X3QpYnBbMF0gPDwgNTYp
Ci0JCXwgKCh1aW50NjRfdClicFsxXSA8PCA0OCkKLQkJfCAoKHVpbnQ2NF90KWJwWzJdIDw8
IDQwKQotCQl8ICgodWludDY0X3QpYnBbM10gPDwgMzIpCi0JCXwgKCh1aW50NjRfdClicFs0
XSA8PCAyNCkKLQkJfCAoKHVpbnQ2NF90KWJwWzVdIDw8IDE2KQotCQl8ICgodWludDY0X3Qp
YnBbNl0gPDwgOCkKLQkJfCBicFs3XTsKKwlyZXR1cm4gZmR0NjRfdG9fY3B1KCpwKTsKIH0K
IAogc3RhdGljIGlubGluZSB2b2lkIGZkdDY0X3N0KHZvaWQgKnByb3BlcnR5LCB1aW50NjRf
dCB2YWx1ZSkK

--------------zr6CbVGQWX6RisOJb43HEyES--
