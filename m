Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A5606A31F
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a+7ORI97;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CDdczoKc;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=zoXSLHLH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64FEF810C3;
	Fri, 30 Oct 2026 02:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXC5FNqtDurq; Fri, 30 Oct 2026 02:08:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6FAC80F4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793326118;
	b=gnE0FRw1s7y60U3iu/bydZoVO4kQJ4kpmA+/sWL0szdPBOCjzWv4qF9uksjxMm9Fw8+h
	 /P0H1DKuXd6eLMRaXjNMqN6iOExYlk3t+NAFrf8t+Z3XZAmWceQ834stP8Y2JaVjHOVgz
	 u2XYJlucNmnj5Nv54GU+9iCKaaNfgQ1T36GBB/QF1TfpP60BN3GLKAylXCuOaDZx3OYGs
	 pZTkB+zJKvOQAN8+lROf151tMkgozLYJOU30+1giAq4Wxypy8y4XS5pe7lSgZF4wfKuuE
	 s58q+CFyPxC2m3r5R2Pl4O1hnGUv9VLMChbhlMIDSu8tTrg/Vi4meCfVJPyvPJiGXlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793326118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2d56dHz1J8ErdhrHTQT+QBWuobPVJ521y1jIc59WPvk=;
	b=mgN6dlpoEqjatVC2CcIUE7C+waBgm1GA6z9DodfudZhwK76hEgHxGKLQ0UsP+6xQ1A0Q
	 4lkXJ03P+50LeVpEiIhWQARZQiKsO/auG8keZbC1y4lGI2R5lOWxjit66FBajoLvddx9C
	 56OZs3MiGTywpYC+/UG5TD+hjR1DsIwCPQZHjbAhGLKy1re6o3PXr7hUzikS09t4JZBFT
	 rX5wFrYdPAClpQkFq5EU9Kns4whcE/68NeoIHdabLDbibQPRV3GxZVcJU7uhzrnfM+zAb
	 b8Ze5e95gLwOU1mxT47l8ejIUvCNoo4fHDa/w/K3FimxSuI/fGwJ/4Zs8bB32FABMUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793326118;
	bh=2d56dHz1J8ErdhrHTQT+QBWuobPVJ521y1jIc59WPvk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a+7ORI97htln6/qLdtzBxHdtlhuE+w9fqcvjUoUh7B1or7R2Qw7XCxe3lsFJNHG0E
	 c4oJhl9rsTTAd3OVghvdj4kXh8lvgDVbsRA6WNA4mf7mo5NAUZftKG0+rPbmespoHl
	 qUrKwD38weoIt1cyAkspQ29txNLd3h+Do9gYeNPZu+2lIbYkvOfkBNoMXUWrc2zE4b
	 UxfbPu5Lh05KtxJH+Rzd2JV9EhXE1LLVmFUK01vfsgaIiKO4jtTCYntVYjKw3X22r4
	 Axxm3BfOxYXIFCAOf/EenNrtN6otypm8vqojL/vEaaJvbTqz6wUYnmbO6imCFfxb/N
	 3aOvHnUZd1cYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6FAC80F4A;
	Fri, 30 Oct 2026 02:08:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 0B82C1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id F185F4051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id HlMyQ9tyL_h0 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:08:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B6A2A4051D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793326114;
 b=SoDF3tSpR2Zv4SZLnBBSsRftWU+zrNJpaotQPVdXEemKOfPpZstjAe6QJx3P0Xy2Ohar
 cLw69BYy6wQv8iHHGc6wsohR8FDAw7YNQp9APPhUfbktwanSm5nJWsKHpMHa4oljYmsup
 RH/KE96WNEp7xjUV1542s7+eqhwUhCkiRPLGXgLi4+RBT/1HCb3tbWDFDnP5osL500+Jh
 K9NkI9SGH2e+z33ZJpi9tulVwsjQs3jrxcvDe/Ed6uD+rAR+1PXEAl+NJSPnY3cGovoSB
 U7RSBeRswqqVgfgfyg50IWaWDmJjwQ77VxEHueqR1qdPOn9Ud6a2bR83p7+Nbaxqp9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793326114;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=2d56dHz1J8ErdhrHTQT+QBWuobPVJ521y1jIc59WPvk=;
 b=VtTZNrONlRyPz3N/F0apLCOHLrmggi7g3zJ6w6AFqB3rxetDX59qMEnFftO3kM3SocYt
 izkbCp17nJCoBT6iCcKccSIHLlKMDuqS/ONdDiXClpJOJOR1BSV0jX+kLny7rSPl75cpw
 ownI1Mu8YdotoL3sqSeUiiBrTpfAxV6gTkkGpGA6LsW5DTImQpFnpf6i3O5PQf0jfztqg
 lXW4urncELWGt+9AjeYi0b7WMxe/M+SNOmIhamZh1fgo76XAJqbHCvJs0x4B5YAprnSjz
 Tv5GLoBqU++BnephSzAA37GcmVJtmL5RVV0ub5rBrRy813VercOWe2Fq66QbjrgPMgg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=CDdczoKc; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=zoXSLHLH; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=CDdczoKc; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=zoXSLHLH
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id B6A2A4051D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326110; bh=2d56dHz1J8ErdhrHTQT+QBW
 uobPVJ521y1jIc59WPvk=; b=CDdczoKcs4hjWRfKyAT3/K4MSIAzKhCeJ838JGr4Z+cA20WbBL
 tpEhLyL0sCSGIUfFwEpvAzeEKGnYe2QqTmRfAsCUDQ2mLkXLdOHFdtZPAoAdoyqtgrHRvIYP0R9
 +D/hxlBelLyNR2BKedo/O1jRqBrU7G2npCQZ/SUxDGE679tI+4Bmpf9aIHZ2IGdcHAz75ENFXNS
 +ZH59yu2glYkzfo3X/pZLaPFHTMaY9j8Ypn6ee8cOYRy5BMMhc1MSDHdNz05jD20V65gjziKwNO
 pqBgrJ81tenHwE0lzaHEA1Y4oQjwQfy3bVrs0C33EIFS3R3i5VzJ0jNqJsnSmA+qcbg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326110; bh=2d56dHz1J8ErdhrHTQT+QBW
 uobPVJ521y1jIc59WPvk=; b=zoXSLHLHrLlD3xeyF71AHfrERI2My9DhEtpSaf+ILtL0mGY9FY
 4Dxo+g8nPuG8jF1ELplCikN6CiwVC9fzVJAA==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
Date: Fri, 30 Oct 2026 02:08:27 +0000
Message-ID: <20261030020832.26572-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is almost nothing in doc/arch/ for powerpc, so this adds a folder
like the x86 one, with four pages:

- an overview: what the port is, the cpu families, the boards, how to
  build it, the config options people ask about

- the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
  CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs

- a PBL guide: the RCW and PBI files, what goes into u-boot.pbl, how to
  build and flash one, and the bits that are fun to poke at

- booting and porting: the boot flow from reset to prompt, booting a
  kernel, and the file by file steps to bring up a new board

v1 is here:

https://lore.kernel.org/u-boot/20261030014925.32610-1-brads@mainlining.org/

Changes in v2:

- fix the mpc8xxx contents, serdes, I2C and SPI do not live there

- CFG_RESET_VECTOR_ADDRESS is board specific, not always 0xfffffffc

- u-boot.bin is still built on RAMBOOT boards, the PBL wraps it

- only PBI is address/data pairs, RCW is 32 bit words

- mmc write block count 672, matching the board README

- add the booting and porting page

Bradley Morgan (4):
  doc: arch/powerpc: add an overview
  doc: arch/powerpc: document the mpc85xx boot images
  doc: arch/powerpc: add a PBL guide
  doc: arch/powerpc: add a booting and porting guide

 doc/arch/index.rst           |   1 +
 doc/arch/powerpc/boot.rst    |  61 +++++++++++++
 doc/arch/powerpc/index.rst   |  13 +++
 doc/arch/powerpc/pbl.rst     | 145 +++++++++++++++++++++++++++++
 doc/arch/powerpc/porting.rst |  78 ++++++++++++++++
 doc/arch/powerpc/powerpc.rst | 171 +++++++++++++++++++++++++++++++++++
 6 files changed, 469 insertions(+)
 create mode 100644 doc/arch/powerpc/boot.rst
 create mode 100644 doc/arch/powerpc/index.rst
 create mode 100644 doc/arch/powerpc/pbl.rst
 create mode 100644 doc/arch/powerpc/porting.rst
 create mode 100644 doc/arch/powerpc/powerpc.rst

-- 
2.47.3

