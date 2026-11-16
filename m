Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8220606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nBjJvcty;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=AuQfjntZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DE9E80DD3;
	Mon, 16 Nov 2026 20:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8LkevfYcmKv; Mon, 16 Nov 2026 20:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDE9D80D5C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794860074;
	b=N5vuuS6UkLpZGXT+LbT0Bvnb7Rf3TV2dwMT7VyttbMYr39em6Ir57aykRWmTbyyMBo0s
	 Awgsz+0v22g2aRMCZwTOW7k3dsQhRwSGVSTYrJxj3dalo0Ucb7XIKLO1YB5NTPvw1WQMN
	 c+0vWCTSeYFJMyYNep40r/+Vc5dXIzZurG8kpzOIuzueBbjZfvROzpDR959LeDLtgRDG6
	 4yIeG6cQ7YYyOXGgoROt8OUbooggkyKrrF8nVlZ3qS2uwzUj56kS7irwZUbG7EvGGXV5p
	 Llqkp+qI4uGz//MAVUy/dUlyCPFXfdDaOJBPBopyeFdmU9A1eZQQF7tBf6MLIcj4JqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eBG2UJE0ZkZ5SSTSc80n2JT83Q8fMRMjackw/MVx4xM=;
	b=XlQwinMNx6S6Idh4IxQ72Ze8cGxdcIYRxWbnawx4GoCJsXsWkOnZ2/v+j9WpIRg9B7IF
	 KRZBY2HMZnrpsZXBvK8/hx6IhTjo9+rkYlcPYpJpD/pzFpmU4jG6QkjEWS7pE6xe/k9sa
	 OWmb119JOsn916/14+WmGXnaTGLx5RSQhQlLRLpyww/UmdupMaEG37hFuwiejlBmbT5JT
	 cFlFZpNYHDMJVYMuFPUDQgQY6UtxtbRrv9L2mD6fXMS4LrFntGb3re7zOyy3pYWA3Dhvw
	 FNT4lBo5es2LQjh4TT7Z5+JaS2YkB+CSu/MJY+8KMEyAX44n38XZNMCcXYi0Q6PEK2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794860074;
	bh=eBG2UJE0ZkZ5SSTSc80n2JT83Q8fMRMjackw/MVx4xM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nBjJvctyE/UQvDeF2SFZHKRMVRDb1w26DZ1PEsYGT8ZxrGvQ5ExmGPBbm2nz9/eI3
	 6TZ4fU16vqDfanOjhaE7DLAkFxzn+q/xBRjnxoL1P2ckgqH6MyA9RdsB6W1RQnaiHg
	 Pl4rL6oCk/8NnCductGXjphTKAMlMKe2SKxQdOm/eZQC3Si+F2iazCMJsjn6IddnBq
	 HcZNtSn+7g0q1Ttd93pe0TOS69ZPblpvQyzni2ukqsg4DJOalyE+RFe0UErFvyJFbD
	 nZtTj+ZVIUYidyKYM8EKEKfBVoD6cWP2GdmEY3I+lpjRVNkiM08wWInsHLP/mwLID1
	 cJo+CLQPSzQ/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE9D80D5C;
	Mon, 16 Nov 2026 20:14:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ADE231E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93BAB40638
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9YTGV_sinEH for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F12F2405A2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AuQfjntZ
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F12F2405A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:14:32 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-862b9c2e78aso992582a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794860071; x=1795464871;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBG2UJE0ZkZ5SSTSc80n2JT83Q8fMRMjackw/MVx4xM=;
 b=AuQfjntZHjLHC+83jM/MRm6TsvhOKOq/b85eTkDcv43KxFqRCZIunpOvAxt/U+QQfD
 uD72wjNO1Ull0EwSvSFWGxa+PjU7iVzsWcdt8Dt1+mZECEaJ07RMwxghcXwwRJothdS8
 usXuO61rH7F08QP/MxSK7lNc+hgGArDmn20cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860071; x=1795464871;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eBG2UJE0ZkZ5SSTSc80n2JT83Q8fMRMjackw/MVx4xM=;
 b=V7uupLHMcJoqt5ua8rSaqTjgu5UE9+ArwO2wA1tSbHt8SB2KNOFjreCVQ+MzzmM2iH
 HoXCBq+yHLZeSt4/nioCCkEd/tq4s/z1QawT3hz6EwL59UOKTPuFu7axntnm1Kuoz3Iv
 zZK6WaOcAXZBOoyLj1CSt7pu1zihddN+2GHU8WC/cuCdd+dW2fkPRDTDrB6/N8hURzyO
 QjrvVEWjjLAjpRCdI0XkTzdvS+HmYd9rU4Oz2X+iggMdl/h3u2/saOzBROj03rF92Y+S
 WimXVklEBVF/VOJivyhXmFbxrCiL7Sf5jRtoxw3+O/kbwOIMdNkIaIFW7wvK4oHqc5lT
 DNEw==
X-Gm-Message-State: APuU4Z9gYKkI39/Rf86c7PzSsYKoNcmskFjs8Rt3FGhmOT1aI8X+HpJs
 wUhJbZHJlIb7BDPkrwg5kgBsMTUfHohEUf8jfuNAsUlUieEzy8jfn2iI6wr7KXJ/f8cHMV+arhF
 1tiWXRC6ctg==
X-Gm-Gg: AYBFou3ghI81virI3IlVtO2Ia6i2QqwhAAyE/kTSyUIENOP0WBP3i57BD1vXDcTaa9i
 LUyWohYQkm9BqePcbsJRlcfIfxhjnEU/vnXyUFnvzdctIuohgaUeAvnJGLx99Tk790qr0DIFQEP
 /E16c275pHTkYvNgFVuY/5dq+cBzvVLQZ/3Enl7XAHOfWOg9JdXQMAIikzi8WaG8U1+DNymZ1K0
 tvyu0we2N0w6KkpVeRrFfjX1/y07W+ps6RX8wUsOCbZ1aFa+ac9zGZIP+owIVFzDlVrgZYqOvMu
 4lKI3Q284lfmdBL1kH1NafDZL5Lvn7WvC4rnpOpth698k0ua88jRs2cH5MhwQKDi23CSxo4H2kV
 mWnS8s6VAs5R/LQsLfhafnXhVcuiglmtOKZDjSZduj7bO2yfSepxcJcfpONRDQ7Bj7o94gm9n+x
 c3g3tDtQizv0tR3+SXxDpMmuRGPiCcb377+zbZzBs4I8Re7I1esLmu1Kz9Q+qjpBx7FAlcoXLb7
 BWxUH70zHZTUn3vrJ7H56L2gOrGrTceIgOlpASp02m+AO9OPKnv0xeup+hG3wenBIN6SA73Jxxn
 oE2IEU1aJzIr7Kioa/mY88FARGavHBbrkjZwTHRqKBmLAK2amJLI9aiJjLqaabkifG3k1iDkyLP
 fft+saNCr4cbKnUoraWH1YbFHeUDqSj4fgal3SgvLpl7YIBKpSIjW0V2o9brVQz59Ne1HpO4mZg
 FuHwdHepemfBYAehM=
X-Received: by 2002:a05:6808:319b:b0:4f5:cb60:33c5 with SMTP id
 5614622812f47-56e605b746cmr9387588b6e.6.1794860071360; 
 Mon, 16 Nov 2026 12:14:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5750329397bsm2061768b6e.6.2026.11.16.12.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:14:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/2] optee: two RPMB fixes for RPMB requests served
 by U-Boot
Message-Id: <179486007040.2550799.14265493913048935825.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 14:14:30 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 16:44:49 +0100, Igor Opaniuk wrote:

> When U-Boot serves OP-TEE's RPMB requests itself
> (CONFIG_SUPPORT_EMMC_RPMB, drivers/tee/optee/rpmb_emmc.c), two problems
> show up as soon as a TA uses RPMB secure storage while other code is
> using the same eMMC. Both were found running the OP-TEE AVB TA from the
> Android bootmeth on QEMU virt with QEMU's eMMC/RPMB model, but neither
> is specific to QEMU.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] optee: rpmb: select the RPMB partition per request
      commit: f473480c43a85961b62a45436a7e095e16c2cdab
[2/2] optee: do not announce RPMB from within a supplicant RPC
      commit: 35c7097a69f64daa4571216bd45b341ca09044c6
-- 
Tom


