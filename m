Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC660C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 13:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A460960DA8;
	Fri, 18 Sep 2026 13:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mZNkjY-JjEM; Fri, 18 Sep 2026 13:45:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A41FE60D74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789739117;
	b=S1TYgG6jKiuoWaWT1C6FEEqHreVJErKdQtpQzGR6Fgl8LeoQgRBRdnAPiPEGfm+FqE1e
	 YvkkJw5areHBLzBv8rWrYafQJN9fHhFhVzea+nxfxh7PdfP+JFmQHr/yvF0Y+7qmthTey
	 Lm37AO8OHQVxNAs7DyONUfKJeNeFOZKq9aKHkY6a7qXEH+ot1LC2mgRGLsYFH1fpzoyKm
	 +PpWxtdeA4Sv1W2zVb35GE4aD/phSOuIsiSrOBkR7iM/5+fs0n3R0rTGj43xeT7IbRy8y
	 1ksn+bDEK6vhy+UdhGLZ/gOv2g2V5EJybkmsTXiFCVvzISPSDri9FU31hdAIPMseMWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789739117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ksrS7Oefslt3xXzyCARhXzGWZ59YHvK5cmSrbdK9Nc4=;
	b=KP59n0x7mUBrjur5dvwQNQ0PgGYdOaVc4GUexKOM3N/DnZx5DRV8+RG4ol0ZWqPJnoI7
	 BBJQL+VB7rGyJ9nk8/EFbxEu5vgnBw7KZzucRRDZXXXnr9mw3wis9HbLSVJRLS3JJjaG9
	 Zm8j6UIUr3+V5YRo+WoxyZOkiyapjP3ZGcvin7Md/cZEm28YTOX7RtJWmXtBUxpR2WtNS
	 xeJTCTQHyqnTTCAYPGYR8exeYOj+O7s2UqA236pIay8+VWIqsI9Q8/x1szlAV6+HKjmRD
	 rEFxna7G27zJh8QU8IwLZNJMrQ6DwalsamrBgh+ldKxZKV8YID6BNy73pFoRMiweDUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789739117;
	bh=ksrS7Oefslt3xXzyCARhXzGWZ59YHvK5cmSrbdK9Nc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrUnvpXPE8dSIxSmgPYjjH08LPbO0vsjQ7VCDxuyZozAmcDd39ROCaX7r+WlFDZpq
	 LWy8fERuJEAMnqIMv1oveQoR/DGswo55Uj4x+scQpOnadmgxFjJbItBm0kcbaENMmI
	 YLgkkRF5QbO/86GTBiNnvCPoPx7yxSXNF7cXo4hxLgf947cqvzTCfHFqiVOvCxvBY6
	 17DJTseVls4lvq4ANbIEViwOpNugELWQJny3O6FkQxJFplBBwPz9RQponx7Etn83lo
	 v8d0GVepTpcIBS+61c/A78Vhabw7llo83RQk3h61bp5xHoDICvdgf23jcqKpzGRjqe
	 U6c7Q5Ap0MvVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A41FE60D74;
	Fri, 18 Sep 2026 13:45:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FB84362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21BD740B91
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hUy8x6dm-fo for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 13:45:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 69E1440B70
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789739116;
 b=AW4EaNq1YOsDxUOIosAx6xOXGfYj23ftkfY3l0ju9mwU0Q/dWZd76M0vMInFPsjIbdBU
 tGZRg4K9sxZiqKe65GwvdCIet7aVB9shQzil+BvF+ZY3pM+PP2Mh8sR1fBDEoM/jn3WUA
 3outS3pHtEhLPbMChtnqqJLKTxK+Q1SAtJfGCeWI/lwgWu66CeCp7FpY5A7g9hZ9EaRhi
 WO88vuk4hdy8hSQWwQmVhBNWbjtfwZ9xethTIj60N2BGbkopjCZ3sq6M9FxOHRo31SbdB
 hKk0Y+gyyo/GNcrlv72aIbL1VfP10j8mhNXruaQXxtOM+rYTuOowr106ZalH01eSJow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789739116;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=ksrS7Oefslt3xXzyCARhXzGWZ59YHvK5cmSrbdK9Nc4=;
 b=BljfRREP4npMuP6WFeIj/SyqIZ5cTSJ7IwuyzmlxGRQWy1salf4Q5qcQvlNTNckYC5IK
 RuW2N3subos0SqQdstUKa2hzFNe4NqB/dqKbtQxczmvts7rn7zHxlZhGTKsOnIK8ArJev
 EcUseMRWyFADMPVKAULRn2WuuVYt3UkZ+ToeErcUV0y3+Xpp83C63rw9eOJ0f+tDmu+pG
 VyhLvm/X/gWiBPQX39faH0SA4MGrj1/A70pXLR3JkrYIDfkhz5KGmiE1Y268uPpRMHvVu
 kiRqoXP82M2QV1vF9V9s0ISIs+5pcgwmLJ9ysci3XOcR08GLpsMm1YXF/U9WZNjs5RQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=cJllbW1H; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=cJllbW1H
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69E1440B70
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:45:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B743168F;
 Fri, 18 Sep 2026 06:45:10 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67C063F7B4;
 Fri, 18 Sep 2026 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789739113; bh=lya+cBv5Dk4s9cYQ1mq6P+P4Ps+UvroZNNX9F/RSEBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cJllbW1HaGCdUKZuoGqpFOJUrsvjqECbgmepoNMDa5XUCzL6JMIrhrbFEo1Q8ZtoU
 1sgQKHcIVKL0iKT7go3MIoe2D4LK6wSe2eKB1aHh7gP/74K91D/Kc6IHusnZ30N/99
 YB6lIddS5dl8N/835L38DvMtFlvJtlswxORRdQgY=
Date: Fri, 18 Sep 2026 15:45:09 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>, u-boot@lists.u-boot-project.org,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] fwu: fix read buffer size
Message-ID: <aq1AZXpdeEHLmPYw@debian>
References: <20260915-fwu-v1-1-cc1fe9640334@arm.com>
 <DLHP3HJCA217.1Z4YOZ4KVQZNO@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DLHP3HJCA217.1Z4YOZ4KVQZNO@linaro.org>
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

On Thu, Sep 17, 2026 at 06:26:37PM +0300, Ilias Apalodimas wrote:
> Hi Vincent,
> 
> On Tue Sep 15, 2026 at 5:29 PM EEST, Vincent Stehlé wrote:
> > When the trial_counter_read() function reads its counter from the
> > TrialStateCtr UEFI Variable, it erroneously computes the return buffer
> > size to be the size of a pointer instead of a u16.
> >
> > As the UEFI Variable is always created by trial_counter_update() with
> > the right size before any read attempt, overflow cannot happen in
> > practice, but fix the size computation for correctness.
> 
> The fix is correct, but the commit message if a bit off. The creation
> is not the reason the read works. It works because the current sizeof is
> always > of the new updated sizeof so the GetVariable calls has enough size
> to fix the output.

Hi Ilias,

Thank you for reviewing.

Is that not the other way around?
In the patch the call to GetVariable() was truncated but here are the
details:

  status = efi_get_variable_int(
               u"TrialStateCtr",
               &efi_global_variable_guid,
               NULL,
               &var_size,                  // data_size
               trial_state_ctr,            // data
               NULL);

We are telling GetVariable() to read as much as 4 to 8 bytes
(sizeof(trial_state_ctr), the size of a pointer, in var_size), into a 2
bytes buffer (the u16 pointed to by trial_state_ctr).
I think what saves us here is that we are sure the variable contains
only 2 bytes, which will never overflow.

Best regards,
Vincent.

> 
> 
> Cheers
> /Ilias
> >
> > Fixes: 7e9814cc6c1d ("FWU: Add boot time checks as highlighted by the FWU specification")
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> > Cc: Kory Maincent <kory.maincent@bootlin.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > Hi,
> >
> > This has been tested on the sandbox, with CONFIG_FWU_MULTI_BANK_UPDATE=y
> > & CONFIG_FWU_MDATA_V2=y, and with a modified fwu_boottime_checks()
> > function doing essentially the following sequence:
> >
> >   efi_init_obj_list();
> >   trial_counter_update();
> >   trial_counter_read();
> > ---
> >  lib/fwu_updates/fwu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> > index e9bb1b4fc65..24a8f1ce5b2 100644
> > --- a/lib/fwu_updates/fwu.c
> > +++ b/lib/fwu_updates/fwu.c
> > @@ -82,7 +82,7 @@ static int trial_counter_read(u16 *trial_state_ctr)
> >  	efi_status_t status;
> >  	efi_uintn_t var_size;
> >
> > -	var_size = (efi_uintn_t)sizeof(trial_state_ctr);
> > +	var_size = (efi_uintn_t)sizeof(*trial_state_ctr);
> >  	status = efi_get_variable_int(u"TrialStateCtr",
> >  				      &efi_global_variable_guid,
> >  				      NULL,
> >
> > ---
> > base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
> > change-id: 20260914-fwu-24265a691f9a
> >
> > Best regards,
> > --
> > Vincent.
> 
