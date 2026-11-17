Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A3606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SNSKGghW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=lCLF+q5l
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 313D981080;
	Tue, 17 Nov 2026 09:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cb6b5vRt28XV; Tue, 17 Nov 2026 09:52:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4982281011
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794909171;
	b=iHX8OtKQ4VDv4aECeeENBPf9YYPkT9mV+l+j6ennCehORISP9G5n+eaUY5ftGhibBGP8
	 0cNw3I+iKpu2GJ37SyarnW0h6vg1nJU1XS64PkstN3jegTcOCYMISLMo4UHFKdc2s5IZ+
	 dkxcZPi2a+9H8aCwsIgy0tftoQoYXoFZJj2O6voY4T9MZQV7tF3XeIQKdl4P2QUGSXnJj
	 Y5sP2cAcTKdVyxIXkUS+M3eHwfT14wSvUb6zqPaABkerMd80L98TgsINZWGknZmQew1nL
	 lfzbJaW4yaUMTCBcw6KTFs2RI92IVv0VB8bkYANIPZ451Ed/TsQGVnHgJYYi6/DsiAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794909171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CW3T95Ia+uVFPBY35amHYoJQ+CN6mh+FTBxkOsVKGHQ=;
	b=okrj2HbhSVMW0c+yZxxH8VgYPBkIN6CJz0+aUW7yFw1/J+uYwKgKmhB7D7dRV97lSqwN
	 ucXhgzKnpza2wCFaVczq0TMkMMCdc0a7qEZc6GLWpciAJNNXqJKPb6KhZzddAZ5BzzDx9
	 vzknmFH4doVgGvy7gFs9eecOjfO4tydFA3JC8xpEpu4a79V3RWzuDkTdPz5TjXvIPatAS
	 p7YPAfY7YIhLzc2ll6WQCeNZrud7uGyt4pR3hyUcdiIuugx8m3ZrM8WztmSYtHLB7xF2w
	 fXnh8vWTzhU83XQuV+PdIBMg6EtHTbjcmqXaa0BD+kBtxMPQpYO+PwiwV6KSEatxR+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=lCLF+q5l;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794909171;
	bh=CW3T95Ia+uVFPBY35amHYoJQ+CN6mh+FTBxkOsVKGHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SNSKGghWAjH3JBvS5D7QeZWMiJeUN4kgDSCyeH6oRymEbz+FBTcyyynSlG9Kdi2iU
	 1yo/1VVxnlWxkueLCuqMm1is2P71FLbpHvwqqA5dGSeHeUuwmV75jGmIjGxJni5B1f
	 yYqc0O0RsZYQnZ2iD0DH0xO+vwjFNtwxruFBn8CsjAMOU4xCO5gi5looorBHccqOK5
	 XwvuxI39BpneqEWlwRVLPwNufGNajV2OELhATTm2ZvDLBKt0mXXBEdMzQ8kFcm/FCT
	 C0pYZygJrc+1Np9dpICCld5pz90YhPp9yuaOdgkIzqA9I4U2Ri72z64gfAvdJ9DBwK
	 O/L0BdjXnxPAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4982281011;
	Tue, 17 Nov 2026 09:52:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 592F28F1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EE7B80FC6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUiPlnvvfy_a for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:52:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 552B981011
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=lCLF+q5l
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 552B981011
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:52:47 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=lCLF+q5lUHQ6ivqXDEsDzunPVC648Ycj/fDZOuiyiiwvHKiKFIkcdi9ggS79QnmEtL07MS06JkvxISXrJDDVpiUnk9+3hlueii3cgjMuPxmINod4jRXiEXqCoyL1Dis6TifH5c1olwSZcGWDiQjbh378pm1t+mhYafm1gx0V8hk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=CW3T95Ia+uVFPBY35amHYoJQ+CN6mh+FTBxkOsVKGHQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794909125327234.4504409423521;
 Tue, 17 Nov 2026 01:52:05 -0800 (PST)
Date: Tue, 17 Nov 2026 09:51:44 +0000
From: Yao Zi <me@ziyao.cc>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <bradley.morgan@linux.dev>,
 Daniel Palmer <daniel@thingy.jp>, David Lechner <dlechner@baylibre.com>,
 Eugen Hristev <ehristev@kernel.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Leo Liang <leo.liang@sifive.com>, Mario Six <mario.six@gdsys.cc>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tim Ouyang <tim609@andestech.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH] sysreset: Constify driver ops
Message-ID: <avwjsCpor0wIVwxo@pie>
References: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.900.72
X-ZohoMailClient: External
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:43:33PM +0100, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bradley Morgan <bradley.morgan@linux.dev>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Eugen Hristev <ehristev@kernel.org>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Hiago De Franco <hfranco@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Leo Liang <leo.liang@sifive.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Tim Ouyang <tim609@andestech.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/sysreset/poweroff_gpio.c           | 2 +-
>  drivers/sysreset/sysreset-ti-sci.c         | 2 +-
>  drivers/sysreset/sysreset_ast.c            | 2 +-
>  drivers/sysreset/sysreset_at91.c           | 2 +-
>  drivers/sysreset/sysreset_cv1800b.c        | 2 +-
>  drivers/sysreset/sysreset_gpio.c           | 2 +-
>  drivers/sysreset/sysreset_max77663.c       | 2 +-
>  drivers/sysreset/sysreset_max8907.c        | 2 +-
>  drivers/sysreset/sysreset_microblaze.c     | 2 +-
>  drivers/sysreset/sysreset_mpc83xx.c        | 2 +-
>  drivers/sysreset/sysreset_octeon.c         | 2 +-
>  drivers/sysreset/sysreset_palmas.c         | 2 +-
>  drivers/sysreset/sysreset_psci.c           | 2 +-
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
>  drivers/sysreset/sysreset_raa215300.c      | 2 +-
>  drivers/sysreset/sysreset_resetctl.c       | 2 +-
>  drivers/sysreset/sysreset_sandbox.c        | 4 ++--
>  drivers/sysreset/sysreset_sbi.c            | 2 +-
>  drivers/sysreset/sysreset_socfpga.c        | 2 +-
>  drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
>  drivers/sysreset/sysreset_sti.c            | 2 +-
>  drivers/sysreset/sysreset_syscon.c         | 2 +-
>  drivers/sysreset/sysreset_tegra.c          | 2 +-
>  drivers/sysreset/sysreset_tps65910.c       | 2 +-
>  drivers/sysreset/sysreset_tps80031.c       | 2 +-
>  drivers/sysreset/sysreset_x86.c            | 2 +-
>  drivers/sysreset/sysreset_xtfpga.c         | 2 +-
>  27 files changed, 28 insertions(+), 28 deletions(-)

For the CV1800B part,

Reviewed-by: Yao Zi <me@ziyao.cc>

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
