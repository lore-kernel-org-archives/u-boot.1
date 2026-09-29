Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EEACA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0005880EFC;
	Tue, 29 Sep 2026 12:52:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Una683KwSrlA; Tue, 29 Sep 2026 12:52:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4A17E80EEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686374;
	b=sIqRQ0b/A7u7h3LsYXD7FOJxXIZjf+KzKdB/17faHRrOoekIY1iDdNQfj+47WWMKGClG
	 p0PouKr7XTE4Fb1DeqrJpjvwdoGZUVx4jhlz4eUYG2Ih4XWJ+Iq4sBp53V8rShm6rGJrI
	 bLCnFsNo/c8SZhhLKX0G83cy/enK2fcwYECd81+gdsNqWWKsnSeJV4UToEyHAJ6rLPFKm
	 VLHMpRaXi3zVBi0D7+kPWaRYcIKLo63Apqcy3K/9VnAImdwY6wn9j4SqITbQgKdpVkzA1
	 hZMiOvBbt1aK+BYibaYmZ9Ozp+LQfFgaLsPWlfXtNGIUIncXQwklbMF2mWm0hOaXDvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E8+NN45i3yzs4wT3HszFUC3WYrF1fewMPZ1uT8o/HVM=;
	b=fVDttkfKOfB3Dtz00/OOj92H4vDsO1uEk7hYSFls8UcHJLD8QPiY6mzw368c5akNeqXe
	 PNJBZVzStutHf6fVB6Wq9nsOkc5WaSpXQwMQbJJOHRwmxZGHSCG+YCD1zx3bmnLP9EIpc
	 0YrZIcmtWga6D3WAulx1ngvm5ihFnu1DGIy2UHHF4QwHackmWfBp6JV5CtRZ9o0/Z5Dl/
	 BS/9oq13BZZtvn9ATmYN8wobne293gHOLIpAHWRP3y3Dn41zC0BzQ7LNjbfYlvLfm3XwP
	 60O0d7zpa/hYZOC+j34jzxeza0JEISabWfrPfXNlqt9r471UbN+WdoPsAbpnhTm+kGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RF9zPBgV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686374;
	bh=E8+NN45i3yzs4wT3HszFUC3WYrF1fewMPZ1uT8o/HVM=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SDgK76NBPPrSCYL+Ay5PFHjxqURw/bX9MaSNc1RgNcD1fnm2Q6kLnEC5mvUvPLMlN
	 ROrxb/lXG53MvCcE/xUvalzlOhFOv8xQy9jsbtqkzQI7rBye3hYbhWUys1uK1hjLzi
	 jtFNA86lvDY9yoahBBB6YnY2f086JTms39x7RGQZpB6bRZXBvhzGEWe3EkgUUEZP4e
	 IkJkpMUrjUNo0ettAoILToF01VQId9wlfBDMEWC4LG3Q9Tlbue5LfKfQxRIx2BZSRm
	 i90ES1nPqPLrYHHp0JsohwPNW3HaeX/IXv93VaK/clamrBErUWN8a52it4NPZDyal5
	 H56bXLu/udyxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A17E80EEA;
	Tue, 29 Sep 2026 12:52:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37373335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 03:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2858680C12
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 03:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWmkhTgWtm2l for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 03:29:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 755FF80C10
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::448"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790652563;
 b=TOAvEeqywPnJkVzEsmP2OjcOYpCOxx9rysOC/ngwtRW9BZn2p4lS8sKK1ma93C3/rE8M
 PBMTmSCgaoN5st0QTEmcBJU938cKSJuysWGxuJOybfoOqsfV6Lx5LDUuX2CWP1frZW/Yi
 NCXZjNRRO2tILE3uVfNNEgURGbEHi4nfte8uj2TbCmms7YvVUaCoX0XPljQrWWtRoxfm/
 xWeQQEg/QoEjXDbgl7R1Ee4JLSeOeRYvBATgQ2EjQymweWMj/Tgf+FJhck+J1t0hRIUde
 Oi4Gfsee1VtR3bXYeVt409Wiy/U+1OdTJFhgEE4/c8h4zLdBa5PqSe0NK0yeiFNmSHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790652563;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type;
 bh=E8+NN45i3yzs4wT3HszFUC3WYrF1fewMPZ1uT8o/HVM=;
 b=CYStP8J305V0Oz0uUXTIU6efSc7SMn69ILO7KD+DNfbbG2qMUWol4MOO6INkXrF7eKX9
 aKWpCLVAVVsi1QRFj0pd6+uCObTmPKxXn8xXR98Pcx2hJvsh3ub0dWLejr1JqM9+Tk84k
 DlS4AlkRU8SuzI5BpH3bdGRDAEX4I978zisuNli6NTw6VJkwAat5sJXGyjH9jk2sgC2C3
 7MXqoYnycqQn83JjNqHaeSqJdv7fZt3+d9rg9mRVIi0DORnhqMYn+huZRM9Ql77TBqc8e
 vW/PlzwibtBa62hWCRNRYWcgnoagXehJUZ4i3MMhEGrshWjoTroyD4FNLw4JHRggUwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=RF9zPBgV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::448"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com;
 envelope-from=3kjc7agokbj0rszmkdxigtfnnfkd.bnlt-annskhrsr.t-anns-oqnidbs.nqf@flex--stanleyjhu.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=RF9zPBgV
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com
 [IPv6:2607:f8b0:4864:20::448])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 755FF80C10
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 03:29:23 +0000 (UTC)
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-882d8c4239bso1435632b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790652562; x=1791257362;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E8+NN45i3yzs4wT3HszFUC3WYrF1fewMPZ1uT8o/HVM=;
 b=RF9zPBgVZsw0kGEYax6m232rqoZgS1luqbBDu8xUykC8WmmEkoiFK/MuUJ1eEr+EBq
 OtMQY7FVMesTzuflC8kE15vaBWAnzG9D+l+NS6T2U1rzaC40ctPYS1n1i7hexcgpeicg
 WY2REk/mr/Trw0ZegpivwxNkyAsyFRPOUWq1lkNAdyIOHu40HnnoVkseFxGXFc+DeFAv
 smggE02kM9wtMi36PgUPhKElBJCyhDRznBpE1uHAckCxjCLQnD44lDl5/y908r/8AKat
 2/bFVi7V1/BLvv+IIN1leEZ7f1wMjvPaXnq9rMQSVWfEO1nbEInwujKFWaz54wHOOfel
 icMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790652562; x=1791257362;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E8+NN45i3yzs4wT3HszFUC3WYrF1fewMPZ1uT8o/HVM=;
 b=TZweFdK/1aa8cFqUlSWqutlQDPMxypuvAGdLxaDHTqQkhafqWhM9AQefw+9yHcr01O
 SV9FrI1dWZcAEAZbrHrNRtZdU4w4+V7Mi3qrsBc1XFOIJ4Pfww3Sw2tmmCMkgM4XRsqV
 MmzQFA27JhBSwEnEjCv+5/bJ5mIVpW2UF0i3ek6CV9BAd58qCYnbuHmMBvrtvgoPuwZ9
 MyRDqasfOVsmMgL47tLaYwoGcqzyPyOz9/rcfF6YyjmqefaBqCC+y6q6fyyapWc9GyA4
 dqc5ZrMFaM6k1epPoRSnlls4rQNE7AOdU3zEY+BUSGXAGggL0hluIpIJ3gRyRvtlJjZT
 sMhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrDWHqK7XEJrs66rvfh53eyQB/KAgAQdm+CNW81RRHJCrUl2q2xOE9AArL0gX2wHfcuk4uviE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kkOC4OsRLxjVfpoGLoJDqbMZjxn1GlCBQxjhZKLuorSIRsvvrr
 xIkRnF192TZqVDWxwsCikpo5SxH/8Vxwmor2NbPdxs/KvHzJzRLGf1vbNf+lbh2NSKDgTQYcua/
 wWJwiapJ0lUYFDy/dJsOeug==
X-Received: from pfiu2.prod.google.com ([2002:a05:6a00:1242:b0:882:bcd4:900d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cd5:b0:878:3507:8d65 with SMTP id
 d2e1a72fcca58-87e9dfafacdmr12289995b3a.44.1790652562162; 
 Mon, 28 Sep 2026 20:29:22 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:29:20 +0800
In-Reply-To: <20260918200641.2286077-4-jorge.ramirez@oss.qualcomm.com>
Mime-Version: 1.0
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929032920.1391393-1-stanleyjhu@google.com>
Subject: Re: [PATCH v5 3/6] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
From: Stanley Jhu <stanleyjhu@google.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com, 
 tanmay.kathpalia@altera.com, neil.armstrong@linaro.org, 
 bhupesh.linux@gmail.com, n-francis@ti.com, xypron.glpk@gmx.de, 
 s-vadapalli@ti.com, michal.simek@amd.com, jbx6244@gmail.com, 
 marek.vasut+renesas@mailbox.org, sumit.garg@oss.qualcomm.com, 
 jens.wiklander@oss.qualcomm.com, u-boot@lists.u-boot-project.org, 
 Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:50 +0000
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

On Fri, Sep 18, 2026 at 10:06:35PM +0200, Jorge Ramirez-Ortiz wrote:
> +		/*
> +		 * A power-on or reset UNIT ATTENTION is a transient
> +		 * condition the device clears once it has been reported,
> +		 * so retry it. Any other failure is final: stop and
> +		 * report it.
> +		 */
> +		if (ufs_rpmb_sense_key(&pccb) != SENSE_UNIT_ATTENTION)
> +			break;

This retries on any UNIT ATTENTION, e.g. 2Ah/01h (MODE PARAMETERS
CHANGED), not only the power-on/reset one the comment describes.
Would it be cleaner to also check for ASC 29h, as the Linux driver
does? Commit a8a34238e5e6 ("scsi: ufs: rpmb: Retry power-on UNIT
ATTENTION on the RPMB WLUN") in the SCSI tree retries on ASC 29h with
any ASCQ.
