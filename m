Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1507C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94E06607E0;
	Thu, 20 Aug 2026 12:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mb-GQ1hJ3FHq; Thu, 20 Aug 2026 12:13:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787228008;
	bh=Mc5ujPfqg9YqNAhXU8rU2v36y3EkXp1PiYikU/5Kno0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKQ6GVqW69RioJTnKdx7BclMkKpMiSLkPdRZ44oMy65dpiLljmuSmTYVrICuSyFwU
	 zgVpjJDD4Iqy5ZUGeq+SvtUrhKDPWbIj0+V/JNYpPOOqttfqZlsHdxKj+WlW79ivfE
	 4y+GFLd3F+EwiVvND0pbMn9eoLXfTwDmoGG5TScKpspoOsKHHqbGoBx2rGe315M+Mx
	 TDRYzJx3AxSdOb2EJrw/+IE9La06eWLMceaca3Qq6AH5izeYj+b53cFNhdZ1elrfiv
	 VGRc6uFIsQrKDdEOHmjKoiV9OleQ5YU3gjWYQU0l9FwKzA+uNoSvILQ6UdDzV1+IPH
	 Vs7by51RG3+6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE8DB60794;
	Thu, 20 Aug 2026 12:13:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A39139E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2060B402A8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ptu59DFZJKhA for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:13:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Cr6J5iog
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79E7240291
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:26 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so2589781a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228006; cv=none;
 d=google.com; s=arc-20260327;
 b=O9b2FzFq7VKu0BCsFDxm9WHSs3SfRLmqJibMMAKyB0EJTnWIPHX7UwKT204sAtNMuW
 RXY6csOVQ61hSDUT3pzChhEejwkQL6Uo6RiVg8i8WDq4j79uRYFNNVOmJCjMo1tVi+iq
 lwGjzoCTChThtS6++PpA3I5LqsQg9BDj0UDAbhYkIfWIL2KwGs6kcyEWb1ZVpr/GmGsz
 AvJZvydYJwtNeEkeI5sYY11gSjzs44F/z7Oexdfhr5kGZKZsl7p7oF2+Uv1AxBlX7geO
 sHpB01O/xrzRck29wLpTp0BBUCm+zxFWWwXT1E2XfhC/g29zlsg86fhseDsxVj+bq3+6
 1KVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mc5ujPfqg9YqNAhXU8rU2v36y3EkXp1PiYikU/5Kno0=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=eias6n+gRQEPT2j+4q0CKjxo/elvnWJaaTYnVakmlL+FhPxtMi3aaL0zp953YXFZRf
 G9axoXOYPpEdB85/JkErGm/MP+Nf+Shgb9Nb7iDSFpiRPh6uX5ij0BAN/a6ceT0+q3T6
 bh66zUHDbpealVcUKexHkASUq5kcSEnCZDBWptOA4LsGusLckn1sl3wJ1YxZ94ESM5Cu
 x/9r7M4IHqsOkABgLc0k39ZnTvVB5ZtCNK192BRQL8JX+KbzKwXHPlIj9LxHqXLGCUo+
 tC8j62afz3eP55voNUDB7So9QqrK8wdInfXyDAGLusDEifJE4UNzPwLBK5RF3er+tN+z
 LUug==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787228006; x=1787832806;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mc5ujPfqg9YqNAhXU8rU2v36y3EkXp1PiYikU/5Kno0=;
 b=Cr6J5iogwVHfwhggwO56glhhPDXWYzbGOMzUOdULo4kdUduB3KJVOjwJ4oHKbezAiU
 GttnATVrGqTZprTm0j30t+T/PODrrvZ/TIbEW8SlB0OFtLKRLMr6cgJq9TVZMzJRKw63
 +FoB5p8iFP8hIsnGRjpxEpnBE3mCXB8+/2hsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228006; x=1787832806;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mc5ujPfqg9YqNAhXU8rU2v36y3EkXp1PiYikU/5Kno0=;
 b=fUuMTyrz1FF7zmOhR2iBJ2NJQyEP0mO1SGt0ZhY9aLc5yPV8bcUSAw4kSyi2wxZu3q
 l3wn4hDeHstGiVIvPW9t60TWAT5sr6jrL2w+GP9OHVVKLkY6aOjgOAZlkGMUfSyOawnA
 2/Qd4bePgRNuKgOsmA9b34KzTGln49NSbcHfNNv7YFca+WcqlNJCfLoumWX0BPrzwoBj
 lA1QPw0aMVk1EAJtImRLxvCjqF1r6SgYmGC9OdWukFevI5x781Xvl/dNoYsaNW4jSrh0
 FPHsomJPHXyo6eTHsgA6g+pVZJXsRMgqT+0w/GaEr7OIMzZdZCkInnffQ3pedS1X+sa4
 yvDw==
X-Gm-Message-State: AFuF++nVvpySAJ4wyR6osdnlZdouHds2BoGndoS6kAgWVet5rG1ZlRs1
 cwe80A0n7Pa6fV9sg6vPGxsrvVqBZwvt+MQQgk0VNOFnjD3m3zQW5VRnbsJPMKN41PVA/ttt6EC
 ZLzYjtQStBY0He25orHnsbK9PBya2ryAUAXCIcW+X
X-Gm-Gg: AR+sD10DeyGaK10J/LVclRVJxnm7Yv0QjUiWQ8LjHHgPQ/RltLZ44jH/zxX3B9TkhmJ
 8rSus3aQHtRpe4kDOLVZaQk6Sv89V5vrhZoWgbe2azuEfTOe7k8xyfe/l+N3gxqMQ0IdevSH6sH
 8sQP+FoxcmoEJWZrPmriTlRZS/syTI0+bsv1ibguZKWk7X7Ke2beyryY43JCMqV33VoEy3KdyEk
 JLv0zqAy0NS5AVNR3AgxL9UlwiNXrzb3/Gya7ptscvyiVS9NLD5HWbI0GBC/vwa6II5OqACbDtb
 utDBQ3JhBmoYw5g+fTpzGTDFWzh85tDLBGUuPrCI92I=
X-Received: by 2002:a17:90b:1a8f:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-3958125a864mr22460573a91.15.1787228005689; Thu, 20 Aug 2026
 05:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-8-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-8-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:58 -0600
X-Gm-Features: AcwNN1V-5h2pnHptyiG6trjOhXf6Uz7WK2fb8RSKk6i50mlKzC4oh_M7_axAnss
Message-ID: <CAFLszTgf+=CdNcw5Tt9_-sPiqxWT+_gzTOa3xK-6QV_EwWoS5g@mail.gmail.com>
Subject: Re: [PATCH 8/8] doc: usage: reset: document device-tree-driven reset
 modes
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji,

On 2026-08-11T05:18:35, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> doc: usage: reset: document device-tree-driven reset modes
>
> Document the "reset -<mode>" and "reset -l" forms and explain that named
> reset modes are declared in the device tree (a "reboot-mode" subnode of the
> psci node) rather than hardcoded per SoC. Describe the 1-to-3 cell
> mode-<name> encoding and note that U-Boot's 32-bit PSCI cookie means a
> 3-cell mode with a non-zero cookie_hi is rejected rather than truncated.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> doc/usage/cmd/reset.rst | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)


> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> @@ -22,6 +24,46 @@ DDR and peripherals, on some boards also resets external PMIC.
> +Each ``mode-<name>`` property carries 1 to 3 cells describing a PSCI
> +``SYSTEM_RESET2`` vendor reset: ``<reset_type[, cookie_hi[, cookie_lo]]>``.
> +``reset_type`` must have bit 31 set (the vendor-reset bit). With two cells the
> +second is the cookie; with three cells the second is the high half and the
> +third the low half of a 64-bit cookie.

'must have bit 31 set' overstates what U-Boot does -
psci_system_reset2() in arch/arm/cpu/armv8/fwcall.c ORs
PSCI_RESET2_TYPE_VENDOR in unconditionally, and reboot-mode-psci does
not check or reject a reset_type with bit 31 clear. Either soften this
to something like 'is the SYSTEM_RESET2 reset_type from the PSCI spec,
with bit 31 (vendor-reset) set for the current users', or add a check
in the PSCI driver so the doc matches the code.

> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> @@ -22,6 +24,46 @@ DDR and peripherals, on some boards also resets external PMIC.
> +-<mode>
> +    Reset into a named mode registered with the reboot-mode framework, for
> +    example ``reset -edl`` to enter Qualcomm EDL/download mode. The modes are
> +    described in the device tree, not hardcoded per SoC (see below); an
> +    unknown mode prints the list of available modes.

Since this patch changes the command's exit behaviour (unknown mode
returns CMD_RET_USAGE, 'reset -l' can return CMD_RET_FAILURE), please
also update the 'Return value' section - it still claims '$? is always
set to 0 (true)', which is no longer true once this series lands.

Regards,
Simon
