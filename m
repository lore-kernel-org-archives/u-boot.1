Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47168CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 979E560784;
	Mon,  5 Oct 2026 21:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPdvQRL98vlh; Mon,  5 Oct 2026 21:54:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EB98F6076F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791237254;
	b=lHgNaDle0gfNsojN1GCNM2ANUwYhhz9hTyjdYVwyuX7PBB3BlgdxudEUm3aXG+XvI6+z
	 nX1LKsmIazuFThgHOPa7Ux+0aMZPLuqUacimBXChgdHE4bmMaMDPep6zo4q40Jlf+t+S5
	 rTNRrGJVVw6zdpVhGuUG6cuMfPLHKZ867B865nterf6eEEwiEiwY6rD09+kNyYsJODkIn
	 W2hg1fv0f1+1dLswOfd6UU6tr89PDjWg+iqOvEz2sWM6+KoJAFmnvDAAZzvt2o07iNFwB
	 uHMW3DPXbR5p3WG26uzv5K8RX0VLrMmBVsP8o/V+3OW6rldz2jkeZgwuQM7RF5zsLcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791237254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kg5X3nfsP4dj94ad8QL4QxhnZn7v6EdF63E8TA/fhbs=;
	b=SCoC8x6lVbBm0616/r/sZ3Qd4A6hRoPo12Uc3YBCTFw521qqITn8O6pDgQDWNjZZetsE
	 m9fTlx4c9lpnCqfz9/Wqnvwjb68E0n0GZdQPmEhgCZAMAfxm6OATjiVzMclpRXT/N+OKw
	 V1nWprgRJdISuiE65DQSpKgxK4M3SWEFv+cIS4JF4Uf4a7Wqk+6Exi8uch9PHrmo85DNe
	 T2vb+CEFV2sJwPxvqhNJgLdV7anDJUipkRZ6h3rPS1VDLxWDCwm/CXXD7bxR/PBGqbaHw
	 tm4Xw/x0A7dSaC2dDhFruR3JOlc8RyXTUj52IBpSMqe9VopSI08AALKgIFmR9M+D15A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791237254;
	bh=kg5X3nfsP4dj94ad8QL4QxhnZn7v6EdF63E8TA/fhbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JbE8NCjjLYiT03YvMdDuw0ndDsQGZg5zN0lOVYt5dnnXvncHRA+M7EimxBr9Adn7L
	 iIvIuPblx2LFB+ET6eRqrlqKWRLqTTyZcpsKrvktdbBTAR1OwPyuDhF2MGM0egLKUv
	 2QWJiWXqW300x6+bXWAvRGCOR7qwjUOqZE380qVSePsz6q+H35hijW7H6du5y3bSQZ
	 2x3leOp1KWLmHo3GbDHozI8yTeZd7f8x7fqRBKot+4VU558p8je0Ps2hrZWcz5wh/8
	 LxyA7Zs+BeP3rCwnKOF2wfVHLrrxTyPn0C+NZmFeO/FeL5LdISU2VOi0XzOEXKP3tK
	 /9tjIq0sFLi+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB98F6076F;
	Mon,  5 Oct 2026 21:54:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD57F2E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFD0D40204
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgJZTg-2w8pb for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 21:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 19D214008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791236186;
 b=L+v5pTG8dy9s78kdgZn/O1JFPWrgRaxdzsm0SZvQrl7a1VnKdcf+Ck5h98mePqtteg+T
 cbCFgEHmU4iPBXtUG9AhYYoh9Jqc2KtzDeeCo3oT1l9mCX3vAg7YqRt2bsjQUZaSOgtGF
 zqBAPKNLjw2WeP+gyRdttHR54Txr5/rS7KhVX/g1n5NHQezeSd21w2b6LUop+94UAxY43
 huSmwiclfRKS4OGAkb78pQRFlOg6Cb2dVxUDOdofuttC9fx4Piob9jWtlb/Pj4fMIsSeA
 a+f+Jj/3xsugouRYKzfOogkQgnV8jPVE1doo80mCGrb4RUjK+EVCcCHDou+bIBVm96w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791236186;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=kg5X3nfsP4dj94ad8QL4QxhnZn7v6EdF63E8TA/fhbs=;
 b=idoeVN8pB6qJwiTbZWyUDwuGkLInmm0lvyO819Xc/r/TBy9p4xYjPXqR8dZ1yFkAF8br
 H7wMIcR9qRms94z7E0SWCjfLldcsdEu3JBxfSBMbMb5SYjRRoNbYFJGQUqfLi+fuhut3O
 0HRS2bCQBfNtdGNPIGSCdXaLD+1lmU7njfZVrYyLdNoGW4xcRIcw2OHE4kOOJwUjEN24j
 ogvI7PturPZiZ+EzKhKH+4QlD8fRw2Mnp1QFWa06eY6eUOrmoxrtQmuOpt8+B0a3KUcpj
 auJmluVXJdWg1FhvW12XVbieQxmbkYSC/tFaXKTFDnBaWp4JquWQ96GJVHvpjz5tkAA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=c4SotZiN; 
 arc=none smtp.remote-ip=185.136.65.227
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 05 Oct 2026 21:36:24 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=c4SotZiN
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.227;
 helo=mta-65-227.siemens.flowmailer.net;
 envelope-from=fm-664519-2026100521351721ed95cf0300020767-ulgep_@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19D214008E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:36:23 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 2026100521351721ed95cf0300020767
 for <u-boot@lists.u-boot-project.org>;
 Mon, 05 Oct 2026 23:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kg5X3nfsP4dj94ad8QL4QxhnZn7v6EdF63E8TA/fhbs=;
 b=c4SotZiN8SuTj2vIEadjLOuLnMgZXUeu0brgwUx9GNghBBXLeTX6cmE2P9l8+V+kFn46PL
 M84wF2vfKd9rl15DHtFv5mLSgz5+vpzypz+c23Rqa5jmPy7EgWw+BR1EtPmfPOYCC6FMh7z5
 SJJtyopPt1ZB6oR8BLtPC1AoC5a79PY81xb9dGXQ+2+VO+vKLoeGrtr/G51HHn4B+B//u/vp
 DCI2DCQZ0/0//GKEtYBs0oIZfR86/lFWUUwO7mNEXUYmKr0Ss1D+r5RjN2IVmac7e+Xixw3a
 VaRXZeGovgYm+IPHxVhuj2PToGItUB4WdFhZO+MWXmBCGwjx8H7UikXg==;
From: Michael Haener <michael.haener@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
Date: Mon,  5 Oct 2026 23:35:16 +0200
Message-Id: <20261005213516.230662-1-michael.haener@siemens.com>
In-Reply-To: <CAC_iWjKvJPtNvoMdcaw+jg+-9=DNOpSs5Przkie9kwvyE=u99Q@mail.gmail.com>
References: <CAC_iWjKvJPtNvoMdcaw+jg+-9=DNOpSs5Przkie9kwvyE=u99Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Ilias,

On Mon, 5 Oct 2026 at 12:08, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Yeah, I'm not particularly glued on "let's make it on probe" either. I
> am fine with the event as well. I just need a proper justification for
> it, because initializing it during probe seems much simpler.

I looked at what the probe variant would need:

1. Nothing probes the TPM on a plain booti/bootm, so post_probe() alone
   does not help. The uclass would also need DM_FLAG_PROBE_AFTER_BIND.

2. dm_autoprobe() runs in SPL and before and after relocation. With a
   bootph-* tagged TPM node (e.g. chromebook_coral) the self-test would
   run in each phase unless extra conditions are added, whereas the
   event runs exactly once.

3. The event is purely additive. With the option disabled nothing
   changes, and the uclass, the existing callers (tpm command,
   efi_tcg2, tpm_tcg2) and the tests stay as they are.

Having looked at both, I would personally prefer to keep the event
version.

Regards,
Michael
