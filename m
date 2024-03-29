Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE713C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 11:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244228823B;
	Fri, 29 Mar 2024 12:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CkqLhooi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F5887D4B; Fri, 29 Mar 2024 09:34:53 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8962387A0E
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 09:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42T8YiTR104303;
 Fri, 29 Mar 2024 03:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711701284;
 bh=9iPBdqthS6+tYptfx8nZUgpHznAuld0tk7B+jVcKWcs=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=CkqLhooimCyRd0/h6eIjWgLoiJKiimZ/CHDzgGZWkzrdVf9ARFXwdeud9xJ4cXvCt
 uEe+XfpuQ8ce7HIHB8FQStrhcVikGUTGenQ2fBUjoIMwoH7J6dpTh0/1xxr2WtcF8a
 j+AnGqyXLvhTKGQEsy9p1+6l+JAP2fO0oC2qHIRs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42T8Yiqj031035
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Mar 2024 03:34:44 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Mar 2024 03:34:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Mar 2024 03:34:44 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42T8Yhex090238;
 Fri, 29 Mar 2024 03:34:43 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: Masahisa Kojima <masahisa.kojima@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: Re: [RFC] Makefile.lib: find capsule ESL dtsi file when
 CONFIG_OF_UPSTREAM=y
In-Reply-To: <CADg8p94omjw63-K1VkzLx2ohZQpj9t2gxNxhH0_f2zA9-GLtOw@mail.gmail.com>
References: <20240327023451.2288523-1-j-humphreys@ti.com>
 <CADg8p94FjRoYkvdSHJ=2MycXceXDOQeES1S6VCNAuJ5ZBZqDow@mail.gmail.com>
 <86jzlnvw75.fsf@udb0321960.dhcp.ti.com>
 <CADg8p94omjw63-K1VkzLx2ohZQpj9t2gxNxhH0_f2zA9-GLtOw@mail.gmail.com>
Date: Fri, 29 Mar 2024 03:34:43 -0500
Message-ID: <86h6gpwi58.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 29 Mar 2024 12:13:44 +0100
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

Sughosh Ganu <sughosh.ganu@linaro.org> writes:

> On Thu, 28 Mar 2024 at 09:34, Jon Humphreys <j-humphreys@ti.com> wrote:
>>
>> Sughosh Ganu <sughosh.ganu@linaro.org> writes:
>>
>> > hi Jonathan,
>> >
>> > On Wed, 27 Mar 2024 at 08:05, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>> >>
>> >> When CONFIG_OF_UPSTREAM is enabled, DTS files are in SOC subdirectories (vs the
>> >> top level dts directory), but when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled,
>> >> the dynamically created dtsi file containing the capsule ESL DT node is in the
>> >> parent directory.  This results in a build failure because the #include inserted
>> >> in the DTS file is local to the current directory.  Update Makefile to have the
>> >> DT preprocessing of #includes search in the parent (dts top level) directory
>> >> too.
>> >>
>> >> I'm not sure if this is the best solution.
>> >>
>> >> I was also tempted to just manually include the capsule-key property in the
>> >> board dts, and avoid the Makefile implicit inclusion trickery.  I would actually
>> >> prefer this approach as everything is more explicit.  But this isn't an option
>> >> because if CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled, the implicit inclusion of
>> >> the dtsi file happens.  It would be better, IMO, if we only included the
>> >> generated dtsi file if CONFIG_EFI_CAPSULE_ESL_FILE is defined.  Was only
>> >> supporting the implicit inclusiong approach an intentional design choice?
>> >
>> > I was not sure if users would want to manually insert the contents of
>> > the ESL file, which is a binary file(a few hundred bytes at least)
>> > into the DTS. If you prefer having such an option, we can change the
>> > logic to what you propose. Thanks.
>>
>> What I was thinking is that one would explictly add the capsule-key
>> property to the board dts but do it just as the generated dtsi does
>> where it references the .esl file.
>
> Okay. In any case, that can be done by having the addition of the
> capsule_esl_dtsi to the dtsi_include_list under the
> CONFIG_EFI_CAPSULE_ESL_FILE  conditional, isn't it? That way, we have
> both solutions. Users can then define the config flag to automate the
> inclusion of the capsule-key. Those who prefer to explicitly include
> the node to the board dts can do so on similar lines to how it is
> defined in the lib/efi_loader/capsule_esl.dtsi.in file.
>

exactly!

Jon

> -sughosh
>
>>
>>
>> Jon
>>
>> >
>> > -sughosh
>> >
>> >>
>> >> Thanks
>> >> Jon
>> >>
>> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> >> ---
>> >>  scripts/Makefile.lib | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> >> index 12857316c58..62f87517c09 100644
>> >> --- a/scripts/Makefile.lib
>> >> +++ b/scripts/Makefile.lib
>> >> @@ -334,7 +334,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>> >>         (cat $< > $(pre-tmp)); \
>> >>         $(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
>> >>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>> >> -       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>> >> +       $(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>> >>         $(DTC) -O dtb -o $@ -b 0 \
>> >>                 -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
>> >>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
>> >> --
>> >> 2.34.1
>> >>
