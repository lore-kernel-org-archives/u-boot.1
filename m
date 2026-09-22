Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586DC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 09:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C995480DCC;
	Tue, 22 Sep 2026 09:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahpJAW-QRfnf; Tue, 22 Sep 2026 09:11:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CEC1B80DAC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790068267;
	b=VUnGWsA6Ph4vyvAvZoGsSsPdKZ9CNIF2p+54F45G+xvLd66vs9uVnhwC3nTf8IEgjznw
	 6DpU2wk1aYCXIr2Vx9wYqTvJQQ1SazRXV7tPQ/usphVgGJ6bWVSKBJe2CAkiv40tRpqrO
	 atTIhN2HNuVTWD/hTGXWwJC+S7/+72uZHk1/jkHgQrlXnh6Mv6yL+7ibM7wVNSIFsOPkD
	 qEvz3dCJdG9zGZLk0+D/33MKF6dPAa1vDAk10HVDxCTDji179WsH2clkRpYpJ03EEIlu+
	 vUWg1Gsbz1NCKHCdtKo+TEKEC34YmM1mDXckraf49DOvzBsTf3tjaF3VXFUxMxFplgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790068267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4BSYo/BwQwU+o2+kUwAeU1U3KB2cz+m4R7pl1xlQkTw=;
	b=hvqeyO84OmaLrfIBy6rYMKuDQEhBxkC+mI7TyZK0yQFoFxjDkwuclRV9dqzJk0bxqhsE
	 fvEoX4E+hmmQedn+3mmlPdSKGo+14M+aAHA8uMQljUPsgCTZBnQ+ZOda2FC3eKVUVwtSu
	 SmVyii7sgim/Z4bOdEq+WihfFGJpuk/9bdKmj5bT1VESceY48gF54tPdwS3oTDPQZHdQD
	 khTEPEeIDxZC9Zlvmqy7Nq2DDmBbiLKaWzHdgMTcliEjy90EI8pb88rZVSWEr3oAfE1ap
	 pLffub5YqJBaMFlPQ6OSZW2hb0V8HilV7Y4pQ+GQlKF0vzwZqF906r2VJOmiCUDE4QQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790068266;
	bh=4BSYo/BwQwU+o2+kUwAeU1U3KB2cz+m4R7pl1xlQkTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BW1kEXS/7E+A9wKWUVqOzw3jGqtEBhw/FWN5AWs0bP7EBook0BnVuueVEMTxfqiIF
	 nuGFmGNO6uRAaUKPma1/6Tu5obysYKoJYkO0vo8oUcIticY+NxqSaid6t2m/1/CLDb
	 m+y0tYS9Vzu17v5ISRmhGgE8hgO8h5jUUm3Lx20k6/nuD7aK4v31Ln6Uey4Q3J23AJ
	 pOXTPmeLiGzPgBBRQhWB5LWtFsKVCElBDFMUnnr9e6lcBlLPx6VnrjErabBryD39R7
	 pPHNzmXx1EJUk3mWoLp1Z3maYm8t2JX85rzSxj+A2MJLcHQK2iNYN56KNQ0hb0q0wo
	 kBIZHLoEzsRSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEC1B80DAC;
	Tue, 22 Sep 2026 09:11:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5D0612C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBD0240813
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id awyIMKX8IiPf for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 09:11:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 78D6A40768
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790068264;
 b=g4Jw5bj+jC33Gyh5SKYG/cvuSpwzYdmsZm3YqrxxlwhiwX2VdPOLzPuY3RsrE5pcFF4F
 3cQDOUG+23thPPaKqRvWBbIkw4sus/wKW8cXkrtF6ycVH04gmWCGJHmVHUUUynC5oK5AN
 jlC+gXfyZqOmrTwOTM53KOOTslDBMQuj/kUby/hr7nqBPNFkxirJdMByhhnaIBFh5JjY0
 Wex/mV2dWpBTsr5jl9IzNLcUkAR3rwU2vYRZLlWh3fWnOL51zNJyppnclKUR0SxzUlVTi
 PV3UmJbd/244Z3a3/1CBqAHle+h5R0Wzc5gfi0zLYH2Mc2KshGznxyLD+L4mgtUuoyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790068264;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=4BSYo/BwQwU+o2+kUwAeU1U3KB2cz+m4R7pl1xlQkTw=;
 b=pNmbEIKxf0i3BMgyT1fMqoW6hll9vv7+cdkanDMj5Py06mZnbgGnXQa+fALoVaGgOC7R
 4W3ceGJ6ExyAjNTAvNpQE9M3c3JIiHL3Fpbwx5GOXCGOMFlvWA7hEi1Cr3BdfIku5SJF6
 5ea/80C3mWVi4mlmrbRqC4D+hMCdy0QH7ByKaGQjTmkKAsJvtT8RNR9Mu64XdZKe/Mylm
 SzfSP9tfZ0RFBe0Ub9ySat+mFaNtHhG+xQXdhQMmGJ25GSLxSxYqkjxj9r8KPVGAkK9a+
 CfaEtwC3gZvlL7CrLj6nGmxhK63IgRm9FRtLT3tWPK958Y40+Q/BiarV8+cmdcge1sg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=gYPzUmZM; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=gYPzUmZM
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78D6A40768
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:11:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F07D1576;
 Tue, 22 Sep 2026 02:10:58 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.Arm.com [10.34.111.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1A23F528;
 Tue, 22 Sep 2026 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790068261; bh=4BSYo/BwQwU+o2+kUwAeU1U3KB2cz+m4R7pl1xlQkTw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gYPzUmZM1LMNaxvXTKnjmh5933ztTgvvXmwCn9ESkiKD3omxSHniW3j2k+bKzgijV
 qXRQjzHktf+7DV5/Qxjhb9O0HbA3V2pq8VaZear53SCnShu4qf41I3KnI4dCcUectb
 g5QD5mBh6EF65PCKM+GpmV/pAWJZlz+WNd2FOfn4=
Date: Tue, 22 Sep 2026 11:10:57 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH] efi_loader: fix string table reallocations
Message-ID: <arJGIfu_a-7P6ilb@debian>
References: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
 <BC138B74-47B8-4DC2-9EB9-5FE389909AB5@gmx.de>
 <aqz7nmtoJPGdjwdC@debian>
 <FA1BF842-7E1D-4CF3-B744-681CEEE150AD@gmx.de>
 <arD4D-UUNXzMdOXq@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arD4D-UUNXzMdOXq@debian>
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

Hi Heinrich,

The test was simple enough to write after all; I will send a v2.

Best regards,
Vincent.
