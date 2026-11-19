Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3555606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YLIXMFYg;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=M2n9IHLt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93B4D40A51;
	Thu, 19 Nov 2026 10:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gLxw7EihQLwr; Thu, 19 Nov 2026 10:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 880C640A4C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795085264;
	b=muJZpL+uy6g0K0AGoWySuyk/fs3/lUbynVa0QcnrLsc0gpaakzF+tlSaWbo9cpD9Vxs9
	 gUBOwhpg/IQ/FTCsVyzy9S+QHoW93C9QK1Ree5CZtZO5ThfvDQ5ojD7kdVgROf6xS7sYV
	 TokhaJWbH/gPCUiddKLGWS0NdTlC82KnLxTMgIydjjSFxfFlFNI/zCtRpsgRfZP7X5eaS
	 vNMfimtg4PwboQfq6Jbw7LN+mdAfM3yAekvqI+6nKGD0ne0RkAfFJtxtrB3tthXwGYt/b
	 zTnd7vwzzq6lz/Jx5b4VYH2D9RGuhBnq2SfMBEqKQjj+wPi80AaQVl03r2Pb7LKxIlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795085264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Xtj6vlHUbhqG10qHjuAjouk6iz0w1xEYH3gxgK6KB5o=;
	b=F+y94Lyjm0uCNcMBF02XpSS+FihK2GEbD9pay7nBNkQZ2n2Mc12V5xD9Uken7iVN4Oj3
	 EkQEvnEK5YVhg13McAMx9fIWRovqJFg/JLnqNKaTB/FBcP+F1L2zjTfSf9lhID+IvovNs
	 iUFoYhzhGjyuW2sEftEzVYjshIHofBDBPAZAKeSbJQ8BTacj9UfFYGbmgRlxMw1BmhPI7
	 /orj9zOBW3SxWeRkbuJCkby+dD2I0HcYSJyT04iv6kTQCxxjcaN0FU3kTTxXouih2ILS+
	 slzcv3N2FF+oo4vwoGpVIMW0pJJItv1MFEaCNJrlLmdxlXa+jlK7DGSC62+kquHD7WQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795085264;
	bh=Xtj6vlHUbhqG10qHjuAjouk6iz0w1xEYH3gxgK6KB5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YLIXMFYg+woeVFT1xnyR3MgKlktBvrhSunBuYeYFexW1Ihluc9V5oeM6J3mLH07yN
	 /8Furobiak47MuCVf6KWH11YmljbQ05JXUp5vQ+s4/jPLirsTAS2SplciW0zpR0GCB
	 cs8jT8kP7LhQjKTvZ4/mWCR63FTJu+5p3W40z42O49BqObIdHY2X5U0ka9QXv4bvKG
	 +B38wS5yLl2x5EjmU9yOzuz1eCqfEomnjFAJbNwYIblrxSVpoy1Q3uCEstHyxn+xj+
	 +/oUmxmCkHoviMrHVtxjQSHDcW8XQMzn67rPtPhhORadEvMj3P195VKQfg174Lhn4x
	 wNKYDbfGauanA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 880C640A4C;
	Thu, 19 Nov 2026 10:47:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C28D470B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A892E60B21
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUrgUO2zeTL7 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 10:47:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 211C460ADF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=M2n9IHLt
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 211C460ADF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795085241;
 bh=Xtj6vlHUbhqG10qHjuAjouk6iz0w1xEYH3gxgK6KB5o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M2n9IHLtj3YycB4JKDieTSCvuF5GazAybEopCnIsj+dwfr8HghDxn3t3s/B3LLOfg
 52sQHKRmKPpNk5u47KCpvCDJeNvFFWmS/ftehKTfmuL9tFCV4i1/AOAL1zNFeNpd9D
 uOLNq1iTb7SiYvwT86iEFnd2Vp1fo03dX3iHnXRRoZBI7Uh54v3EF6CnTdNvw/QVCU
 ikkLi6sFM6eDeM72lUGm7i93IgP1uiQIADxQ9X6/yccdPu0aGfG2Z1ssGiaOWt43oZ
 Z0Y8+G00+arf2R0ZO7XRPHuroOsmpAo5VTZQoU1WFu8YhpiJ7n+DPtd1s0ppGOlf6A
 R6MPi+dWzbhjQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3E76DB2201E9;
 Thu, 19 Nov 2026 11:47:19 +0100 (CET)
Message-ID: <b25fff6f-7db4-49bb-b68f-e7d7555ff155@freeshell.de>
Date: Thu, 19 Nov 2026 02:47:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] binman: Accept RUSTSBI as an alias for OPENSBI
To: Zhouqi Jiang <luojia@rustsbi.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>, Daniel Maslowski <info@orangecms.org>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <20261119091842.3062208-1-luojia@rustsbi.com>
 <D5BE1F0AB7875B8C+20261119091842.3062208-3-luojia@rustsbi.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <D5BE1F0AB7875B8C+20261119091842.3062208-3-luojia@rustsbi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zhougi,

On 11/19/26 01:18, Zhouqi Jiang wrote:
> RustSBI Prototyper dynamic firmware accepts the FW_DYNAMIC handoff
> used by the existing opensbi FIT entry. Let users pass its binary
> with RUSTSBI= and forward it to the same binman entry. Reject builds
> which specify both firmware inputs to make the choice explicit.
> 
> Exercise the opensbi entry with an alternate firmware filename and
> describe the RustSBI input in the missing-blob help.
> 
> Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
> ---
> Would you prefer to keep RUSTSBI= as an alias for the existing
> firmware input, or use OPENSBI= for both implementations?
> 
> Changes in v2:
> - Route RUSTSBI through the existing opensbi entry.
> - Reject simultaneous OPENSBI and RUSTSBI inputs.
> - Test the shared entry and update its missing-blob help.
> 
>  Makefile                       | 6 ++++--
>  tools/binman/ftest.py          | 9 +++++++++
>  tools/binman/missing-blob-help | 2 ++
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 519866b82ea..85638310395 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1679,7 +1679,9 @@ endif
>  endif
>  
>  quiet_cmd_binman = BINMAN  $@
> -cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> +cmd_binman = $(if $(and $(strip $(OPENSBI)),$(strip $(RUSTSBI))), \
> +		$(error Specify only one of OPENSBI and RUSTSBI)) \
> +		$(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>  		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
>                  --toolpath $(objtree)/tools \
>  		$(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
> @@ -1694,7 +1696,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>  		-a atf-bl31-path=${BL31} \
>  		-a tee-os-path=${TEE} \
>  		-a ti-dm-path=${TI_DM} \
> -		-a opensbi-path=${OPENSBI} \
> +		-a opensbi-path=$(if $(strip $(RUSTSBI)),${RUSTSBI},${OPENSBI}) \
>  		-a default-dt=$(default_dt) \
>  		-a scp-path=$(SCP) \
>  		-a rockchip-tpl-path=$(ROCKCHIP_TPL) \
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 567ffa96b2b..e8b58ce2ea8 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -97,6 +97,7 @@ TEE_OS_DATA           = b'this is some tee OS data'
>  TI_DM_DATA            = b'tidmtidm'
>  ATF_BL2U_DATA         = b'bl2u'
>  OPENSBI_DATA          = b'opensbi'
> +RUSTSBI_DATA          = b'rustsbi'
>  SCP_DATA              = b'scp'
>  ROCKCHIP_TPL_DATA     = b'rockchip-tpl'
>  TEST_FDT1_DATA        = b'fdt1'
> @@ -236,6 +237,7 @@ class TestFunctional(unittest.TestCase):
>          TestFunctional._MakeInputFile('dm.bin', TI_DM_DATA)
>          TestFunctional._MakeInputFile('bl2u.bin', ATF_BL2U_DATA)
>          TestFunctional._MakeInputFile('fw_dynamic.bin', OPENSBI_DATA)
> +        TestFunctional._MakeInputFile('rustsbi.bin', RUSTSBI_DATA)
>          TestFunctional._MakeInputFile('scp.bin', SCP_DATA)
>          TestFunctional._MakeInputFile('rockchip-tpl.bin', ROCKCHIP_TPL_DATA)
>          TestFunctional._MakeInputFile('ti_unsecure.bin', TI_UNSECURE_DATA)
> @@ -5059,6 +5061,13 @@ class TestFunctional(unittest.TestCase):
>          data = self._DoReadFile('fip/opensbi.dts')
>          self.assertEqual(OPENSBI_DATA, data[:len(OPENSBI_DATA)])
>  
> +    def testPackRustSBIWithOpenSBIEntry(self):
> +        """Test RustSBI firmware as input to the existing OpenSBI entry"""
> +        data = self._DoReadFileDtb(
> +            'fip/opensbi.dts',
> +            entry_args={'opensbi-path': 'rustsbi.bin'})[0]
> +        self.assertEqual(RUSTSBI_DATA, data)
> +
>      def testSectionsSingleThread(self):
>          """Test sections without multithreading"""
>          data = self._DoReadFileDtb('entry/sections.dts', threads=0)[0]
> diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
> index 27dc620bd35..8020e6cca76 100644
> --- a/tools/binman/missing-blob-help
> +++ b/tools/binman/missing-blob-help
> @@ -37,6 +37,8 @@ See the documentation for your board. The OpenSBI git repo is at
>  https://github.com/riscv/opensbi.git
>  You may need to build fw_dynamic.bin first and re-build u-boot with
>  OPENSBI=/path/to/fw_dynamic.bin
> +RustSBI Prototyper dynamic firmware can be supplied with
> +RUSTSBI=/path/to/rustsbi-prototyper-dynamic.bin
>  
>  rockchip-tpl:
>  An external TPL is required to initialize DRAM. Get the external TPL

NAK.  No alias additional to OPENSBI=, please.

-E
