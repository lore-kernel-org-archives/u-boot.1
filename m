Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1A606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pGiQcbf+;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR7ZLKaK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C56A811E5;
	Fri, 23 Oct 2026 10:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A65Cb_ZnUSda; Fri, 23 Oct 2026 10:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F924811C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792750679;
	b=GIlbFztxFmHh75LChFW7SnTrdtjwWz5kUPXmNtG3nqCawS7+KZ5LRYJb8sYvqSWizO/L
	 BDT9tM+jU+ccJeok1ryXA89VptNgVewp6oFsM/eW9abSYJoUvdRQcZesqQdSZFalTIU53
	 h0cC41TsvGZwABCHaXeKhu4XHVG0BVlKxK6NvAGW/JCaJBsFELFjyGbebvcOoRXAefYax
	 Q2qN2AIDkwjwyr0r7mpU6cU+hzMJH8BQyCGegDM94uPbzqcC2TGazBII9/s1L6KppDKg9
	 6iowKCA7sOT8xUo9jQP8JSbQ92SXHq8iwV8gGlCFzi8x8xXrsZk/+ACwp1tg3/JVI4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792750679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qKPsahwaXLOE+GvKr4zS6ep4GAQvHLstdQAojtdkdCE=;
	b=cZZPrMcrAzzF337wFJdW+zaEYo3W5qc8jHe9GrBQgHQh8oMR15lPvLQdzGKBngpmgQCs
	 thx/sGjUQWwU+BXJuUuo007DYolM6IStNqYxJZENmr365q6FL49B5u+vMc7H/HUVkLqB6
	 1bL5rzUJ0ODcOlj37v9uLWFk0POcFi0QyugYHdhBFlaqDlsGniI7IVm1TlbnWxBZ5nl0c
	 PlwSHk9Q3PFylJSxb7BcOI4mDXa/RHxLnkHodf1WfCP2uvzqRqGk/E91z1N8dhG/rXiOz
	 uRS/0iFu8aHhxMqNbEQf8hOMPpYUwfhc0UfTGZTEBb/ID7uJMT+EFiGXCN+oOjHzYTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792750679;
	bh=qKPsahwaXLOE+GvKr4zS6ep4GAQvHLstdQAojtdkdCE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pGiQcbf+LMBKHwpIK/1miZjbvTKTdsM4SbM2DO4R+GRNoifCFuW1M8iteFlD7SDbJ
	 iWjI0uM86XR4dkMXhLP7DPJRoWVadm1TCnEPaV72bHJH7vgh1EJy0lvXYAgmENyiiV
	 PNNPmMZEvSi5X21isjsmOuybXZDrB3l7IJvYoIKRQGcTGKRHNxvNkHjf4Ebea+MSAd
	 fyperELYnNZMBpGxHDTP+D68eVlRNe78bPFl4GZPDQ3h50ak1aHBfiF5Lwz5GoGnjH
	 g3Lp59Gh9Fz6hQhUfiau0R1lnOLkhywF1HoSjs2VUam7za9qJl9hQsN3LSXyy0hS+U
	 j/dD/ltpIgOXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F924811C1;
	Fri, 23 Oct 2026 10:17:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0AFF49D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6F0060648
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PcY31O2P8Uuc for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25B896062D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792750677;
 b=c42AAUwSst976BPSQk+Anu3uuxAZKBMrBYgt1hT/eDD/wtTvp6ZMC8Sh6V0YNx+IJnFg
 o+WfPUqMPKiU4lf97L+WTaGhGxeXilHQhl7hKGDsc9mrgz54u1755B8NqxTA9GCVFj8+Y
 5NWOdSBATPGP8kC3z3PuuqwfKasEbdsYX4y3CzCsgkKlauuxnUqDnWre6wOxHcd7jCLN3
 mwlJ0XyLWS75Tt5zkz+6PV+mXmcBfTQst8YceHbeIeeFYCfItPGXfZC0zuX3i5/+0Wq+2
 Z7w7R7eg+sEsl92XuPzWEDaBmgaQEmdIoIFn/3NK0wHeZJ5j50EiV5UCF6TXuMCQ/Ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792750677;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=qKPsahwaXLOE+GvKr4zS6ep4GAQvHLstdQAojtdkdCE=;
 b=mnG9Eb5mLc2u8zV//yY+uHS1TyMww+FK9sAhpCJRsZMBDFjUkYTa5rO9eOORRS/PeEjh
 3V3tuIdQMLym+XSwjGuBzzO4S1bv0eBdiYXpPByuJ3o8nVr8lS1t15+RqjhnhlBl8LoUX
 IWs2wddLtfU1p8VgVk8oYl4kHZ2WNoJtVvjESg05ZrWrGDyXBoTRnM4QM8lxi4dkTN1ob
 fagUO8OkkJfakJuQ0z2Sgk5W1LdA7Uhx/0K5oBVu6VoMo3Oq3jRbXUYQce8PXFtKd5ADo
 3J98UxCeXO3HB1S0THyHFFW2wGa3HGRlLepoOE1UBwVvcs/FmARHnydQ91uygotM7KA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FR7ZLKaK; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FR7ZLKaK
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25B896062D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:17:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4A224194D;
 Fri, 23 Oct 2026 10:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF911F01825;
 Fri, 23 Oct 2026 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792750675;
 bh=qKPsahwaXLOE+GvKr4zS6ep4GAQvHLstdQAojtdkdCE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=FR7ZLKaKKTUg6baRdxVgqBAvN+jsExcFNDj/aXvrG8MgguuLSFBY94QyZyPI8tqcO
 9VtRtqc/j9hS4ZhzfFC1CodEjGKGsS+KIRnO9TEpiJlXsv1UZk5Z0JKjPhxtVcT3l5
 gn1buuxTP4o+O2Her4/I7vw3qHidp9eoM7berNESVswoMqfsRVQaexV/IURrvFOkVd
 LPGsgUiWZd2mnYI/lij0UX6LTvqfnCaXBdtyAnc5NiFeRHLUip+F2C1YGErqYYh/GQ
 fGDoF1IP0DQpNV44JdZqVtOZSPh28zWaUx8XSNdp+ITStVs7W3dt2QvsCulaHPQJsM
 Ese5WxGbmR+ZQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: fastboot_tcp: act on a command that succeeded,
 not on one that failed
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com>
References: <20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:17:46 +0200
Message-Id: <179275066631.843882.8258790986530597416.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=635;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=LQhiHpgI56aNMMMizZU6QDSXnz37HFd3YvIpdGKw8jM=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9Ztk8B18pbi61K/PSrc9l9d+YtQ1LNVERFJCg8EnV4u7
 NrJGOPbyWjMwsDIxSArpsii99Jp+Tb5rH3BwmsZYAaxMoFMYeDiFICJHFblYFhVN5Wz5tquA0Jq
 238rPFMrvHluy0rlBYyxvxY2SmhqvfxiY3Qgb71YI5f16t1Vz04WmqjtXq1iGzivPbnccrb28Yu
 VmU3/WVl/P/tcYcvp9fv4aq6PIk+e33nvFXzy6CLh/rwXBwwz03TfCXe6xOpXvz+U5Pitzao2N4
 X/ZBjrxjMHV4qK2bFovyi2kNgvoBvk+iOvOpalNzs095u49OX5Ka1mPWUrJI3CDrvbhju/PfMpa
 8qp9IWVnp5vJ55qXLelit2dScXN40Cu+aG1ER4ccyaumftknhLn+W7f+hKL+uyUjuNf3OzE/xm4
 nTOycbmWeKR34STmDtHA36ukNU8pL+hP2LRnv9npf/0fAQ==
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 20:19:54 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> fastboot_handle_boot() takes a "success" flag and boots the downloaded
> image, leaves fastboot or reboots only when it is set. The TCP transport
> passes strncmp("OKAY", ...) != 0, which is true when the command failed:
> since the TCP rework, "boot", "continue" and "reboot*" over TCP do nothing
> after their OKAY reply and would act after a FAIL. Pass the comparison
> result like the UDP transport does.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
