Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C89ECCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CC4E605F4;
	Mon, 19 Oct 2026 09:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F5k5t5Poz6bS; Mon, 19 Oct 2026 09:45:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4824D606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403133;
	b=aQLbcwa2ND3f9xur4MHmm+GpeVqvyJ/S3OjL2iDmdht9L/f60PSvn75yaDzCSH8TMB0d
	 ctsgdc/PQQuzKwSn18n8JNxebidMK5iT1oFmRQ6eROxSeTmTDBMQ7194v0w3MduhXpkky
	 zdkUH+SLVwDVteu+SePUv7EA+0uHcf+qje0v0xHlJUpwUr9AoFjIEMBEk/ELn6w+jjY1V
	 Y9hIrLPwVjXxX+S+VBwCmpipFokO/Z6P4bKKLoUbIHsvn1hwpGF63zC1YeBXJqQThhBZV
	 HVGBh+/iPfZX62USo2TrdMhpMXVeNdc9lFeQOJdrejIjXklYC66Wyck9aIR6duCWk6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792403133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5yRIh41dKCvbIVmtQLAcYNQvDVCPtlfafWDJt0SqblQ=;
	b=mdJKCDcReqRngr7gY6hBze92FuTO0ZtjKKWF/eXCe0z7QLRb1FDdmqp0v9w+0IHyb306
	 ykJD2PAO9xtGrqQUUYWHnOxkGogxQV4Cv9+8x+DmI1UguTk03OUjIY6CJzBDYBrb1OuW0
	 tlA5Jbar1uyBgx7UzWCLQRDRz/yUCFj27VyWAegum1q1qe3VoUeI/GecvJK40dGZtYJ/n
	 56TeVFpdCQEAKd1U7j51uL87meIAL5ZU3SpYtMSYmV5bmFJJxoDlRBbS+BNPVpai/MFbA
	 E0egPAFF0VUsePooHNyO/34aX+lUSBlLU2lhnp7bZxwF5EM8WOkP44LCYQtS6TQQjGw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792403133;
	bh=5yRIh41dKCvbIVmtQLAcYNQvDVCPtlfafWDJt0SqblQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BH1o4swk2pCF2zC2RqlzjLVY2n3cYAxMcKMbRP4tgMlkWHlIVKsXAoLRT7XKIP+xP
	 /0OEFlRlYHoTrjBSa3+p6qK9E1Z+JkQiKcZe7tyL4w8Vs9/vArUkS+BqZtQRKPNy/6
	 QaF6PXm8MDLdF0c8hrnNUyjngq9Pdfe/dyS2peyBZm2V1HgGX2TgZOf1s3tskPBuEp
	 Ska3g4n2MskifFPlClInW1vVz3CJwz7+8MgzJl/kOS+IoV3TEAtANXzQPnrtTHrQ5v
	 3HkN/duq9F9ycZLbLcBQ9+W1xMFA6P69Y7FyrdAS4rTkbj7dXiKEAax1MtdFGNohsl
	 A4Kc0PqkNY69A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4824D606CF;
	Mon, 19 Oct 2026 09:45:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF55E2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9587040738
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbzADuofBQmw for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7688740713
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::233"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403131;
 b=lp/3n9cjSteptCBCfx856WoCMBGAKv2q/BkGnGkAm1KobRXSZ+MJ2i8c8LcLmXKeziBF
 uPr1HghjUWVtgUjeqD1+bdXwaBWePL3ge9Fhe4reRQgiD5rFGutQw3tpiafgGyX7HD+YW
 VvuSjMRdd18tbgThD4tf4SdQZRNrraGUcO7jYDcYvsVVZvnCHtzAW5MAd9B6v/trhxloU
 TiQWjEpf6EvtU/sVcJCMCKpq+Qsf3BVRdHBeZE+TdhK3haE80RbxAmYvJMJ8vD9zK7lm6
 usZNOku1tbfu8zMA5IqMVQeey75NDpXUe537Cvon12n1pmbeTvvC1l5m20F57/eYXXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792403131;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=5yRIh41dKCvbIVmtQLAcYNQvDVCPtlfafWDJt0SqblQ=;
 b=Dd3866vVKoAkCdrD4Xhco5+qQg7BfarUVwwF9agSc9Qjo3ys90gSZ/mRh/B4d1FhzJwk
 FCtcL4xyJLUBZErRWV5GCShWiG0KqcfL7E7bukgVv1XdyySmeCc+r4+zL/CggQFJ3MDSG
 Gcsqmy5jVp+BzOeqrTHP5Qn42pbVVSnRknvmcvPfkxdfupG6NyqwZDub/biiKexa0OT9l
 +YNHPrg43k7vPinvfHTu0H8G0hADasqz3o5YSnWvkgAWcTSRRQGm80JBeQL2m6UeR3Eey
 YbmT5/LT22Cq5Wl8DpzJQ26vh899RJw27hHkKMiL8HHMRHGXSehQPye5X+f5T+QxobA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=XDJO9t04; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=XDJO9t04
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7688740713
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:45:29 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3aae7df0971so12574281fa.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792403128; cv=none;
 d=google.com; s=arc-20260327;
 b=leaK1b+cAQTWjeEVVyaesBdGfJr9gg1q121x1d9TKfbGDU4yK8zdzwX11SOfQSe5y4
 uJz3ERnfdaxffMWOLK7sFAaJ54iZZC38fLSLtQdw1UoOoKzcFq6B+HxOD3wlPyKFVDip
 sQRq5Kr73OnIxWMgRzfb8mE12MvuUGPJX6qwQSNYYlviImqntFZk6SXwSKLXERYyF8Yr
 QH+iAzjv8Wn72z/QYHY7i4S2e+D7Ip+VL6MiQK9RarIWQgjQiwYh/0jJs6UNY7H3VhYG
 YnJ37KNNUnHwdbsXxQScc+exX33EH/e936HQuxOOKeH5F73UOqaNvBftJiuZLIx5Mg9w
 eG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5yRIh41dKCvbIVmtQLAcYNQvDVCPtlfafWDJt0SqblQ=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=E7XxP3TH/LMLyoXNQKOPXzuJoR+J4BqmjpbOKHETuh9qrtR1VJfvLNABQ43f/D4oZw
 GvyXhZWxc5hjMJONE/wRu9mxGr0UEDZ1Ct9W9uJAR/+HWVfuArilu2F80c/eq6wo+IPD
 eBMu4O4o1vJXxYEZ4HozSkowCyIBkSw81wjK980NiOwyVidxfZM87VvNIv9o3atP8Rz6
 bU6xBiXzhaFeiwNBsGi8IUOvsH3DQGn7h6hJNEs7vQfHJIdbd6o5esBSTfoUfpoDde5F
 Ct/2xgRCOBvx8HKdsE6w5Z/QW6K32O+BBrx2FWlVZ89JMMAzGZNvauT49D9lb6yaj7Ed
 cdcQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792403128; x=1793007928;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5yRIh41dKCvbIVmtQLAcYNQvDVCPtlfafWDJt0SqblQ=;
 b=XDJO9t04W13ygOJIobnh2/IdYm7EwhnpRtk1ym0V3WPsAbYNx53kHAueadpUJcR/pS
 kukefoWg1dzdv7QihBRouUd0m6WY1NlwB2EolNIhoy3jACYmlW4bL/U7H2QoFUVA/Bt3
 b3/nd2+arI+bmEOcOZzvHLOrjW4+ZXCL83vTMMPb0GphRGAfoLDcw/i2SEC5kPSm6jS8
 +a0ggKbRlhotlCEDohiNkbhsHY6BgAdLDIb9HuZU5rRgdQn+oLKwZbW7v9GCYlGdmTUX
 /mkbc1vQN/LRXONERz5QIkk6q89oa3hIDvDus9NJs44OzzbtLN+m8FcdRU14hgbEpEyp
 d6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403128; x=1793007928;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5yRIh41dKCvbIVmtQLAcYNQvDVCPtlfafWDJt0SqblQ=;
 b=eixU/p4PV+ill6wXcmyC2Dcu3IOJVjvnp6VzFtezTScB6tQ2audia+5Z0SYsvZtMWO
 MXvxUJhEqoiQAZKMyV/0Lyv1u4k6Hne9E3qax/QNz7shQoSCUYQd4CXZeyWE77bADI7n
 uOJWopgrU5mqwd+6Zr4JQOlxZhGW+s3fj5TFTWfS6N1SDDHYrIxbPlyTdryFkXddOwq1
 E0L+GZkM/Uv29g4drdrASNJm5Ql99riaj0F8hEa4otx1rQFWAgoc+lUknnQigif0gJge
 5rl/kfhVfCj7j6H4EH1WcNw9+PJYZNlhFq7Mhm3BsxL3ZD73rUjOmamqpXZYcUPUIAFD
 Og+w==
X-Gm-Message-State: AFq9FYIg3Lf+HFAYWrrGjIuLvpeGYdLDxfCnHhs4ds97r4PPywvdlDhf
 xF3D/2fPcLIWuzTuE/3MM3vKKlt2oFveFTvOTX5mmjOcjPwyj7DSzGAAtIKb7r+lQJfS0wWz0XX
 mToxZulVjbQ60Lp2RKM1ba0FSgtTr3LiFxwdSWGOf8A==
X-Gm-Gg: AYBFou0WqoPG0nEXKFnytUTc0J3Djon3AJ4brjOZMaQ4D6Eo4MzS6KGurkZ5SuCfBCR
 F+7TAKvCIJDmJbqM+CrfhVbKEUPldD8Jzip1ofNQ4a+dha80q0G64ISrG44X4acONEoro8+Z4Kl
 0hqmP8hJjUkHyaED1OBfJIQli8KKd7zjyXrGIuboj7Lo7eBtOwphFB/4WTA+zHRVQPVMbb4Fs3f
 VpCxMg4U7W1Pa5ZhBhxKv8CWQ8iGQWGp0O6W5dqfm2Ddx8C5Rx+oGKL/dDS1TIoPSiWufIAfwG7
 8A9wAXTnSYhHbba4jX/2RZYk2PPyU4r36m2+vvZmrpD5pH3wtFdO+TEJLrh5IAiZtKB5NRxaWUA
 SbFrtW6semjunZJlBVBGdmQ+tlpFlxpPC0a16WIAA9Wn3Sd9LH33GgFkCRAH6zVQ38QlFXnrLsA
 EmEqr/LGQlrSQ3
X-Received: by 2002:a2e:b888:0:b0:3ab:48e6:6785 with SMTP id
 38308e7fff4ca-3ab48e66d54mr1604011fa.27.1792403127766; Mon, 19 Oct 2026
 02:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <bee14dfeb671f9b8c951879cfaa4160c0cdc16a6.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <bee14dfeb671f9b8c951879cfaa4160c0cdc16a6.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 17:45:16 +0800
X-Gm-Features: AclHuK-24zZN628doiVtHFVBE-mMix5nNbLLfp6HoG8k31KfFMIfDs6K5gwBmTs
Message-ID: <CAH22mJy57EMCEGwWLcy6YkLn+SQV8tTFNpwdrvzsHbQ6kT74Wg@mail.gmail.com>
Subject: Re: [PATCH 9/9] pci: spacemit: do not fail the probe when the link is
 down
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> When the link does not come up within the training timeout, the probe
> returns -ENODEV. An empty slot is a normal configuration, but the
> failed probe leaves the root port unusable, skips the outbound memory
> window, and makes every later lookup of the bus (each "pci" command, a
> boot device scan) probe the controller again, repeating the whole
> bring-up and the one second wait.
>
> Linux's DesignWare core carries on when the link does not come up and
> only refuses config requests to the buses behind the root port while
> the link is down (dw_pcie_other_conf_map_bus()); FreeBSD's
> spacemit_pcie driver also treats a down link as non-fatal. Do the
> same: report the link as down, finish the probe, and answer config
> reads behind the root port with all ones, dropping writes, while the
> link is down.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 53 +++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 9b299ca17a..61c759172d 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -338,15 +338,18 @@ static int pcie_dw_spacemit_probe(struct udevice *d=
ev)
>         pcie_dw_setup_host(&pci->dw);
>         pcie_dw_init_id(pci);
>
> -       if (!pcie_dw_spacemit_pcie_link_up(pci)) {
> +       /*
> +        * An empty slot, or a device that does not train, is not an erro=
r:
> +        * the root port is still usable and the config accessors keep
> +        * requests for the buses behind it off the wire.
> +        */
> +       if (!pcie_dw_spacemit_pcie_link_up(pci))
>                 printf("PCIE-%d: Link down\n", dev_seq(dev));
> -               return -ENODEV;
> -       }
> -
> -       printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
> -              pcie_dw_get_link_speed(&pci->dw),
> -              pcie_dw_get_link_width(&pci->dw),
> -              hose->first_busno);
> +       else
> +               printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(d=
ev),
> +                      pcie_dw_get_link_speed(&pci->dw),
> +                      pcie_dw_get_link_width(&pci->dw),
> +                      hose->first_busno);
>
>         ret =3D pcie_dw_prog_outbound_atu_unroll(&pci->dw, PCIE_ATU_REGIO=
N_INDEX0,
>                                                PCIE_ATU_TYPE_MEM,
> @@ -430,9 +433,39 @@ static int pcie_dw_spacemit_of_to_plat(struct udevic=
e *dev)
>         return 0;
>  }
>
> +/*
> + * Nothing answers behind the root port while the link is down, so do no=
t
> + * send config requests there; Linux's DesignWare core does the same.
> + */
> +static int pcie_dw_spacemit_read_config(const struct udevice *bus,
> +                                       pci_dev_t bdf, uint offset,
> +                                       ulong *valuep, enum pci_size_t si=
ze)
> +{
> +       struct pcie_dw_spacemit *pci =3D dev_get_priv(bus);
> +
> +       if (PCI_BUS(bdf) !=3D pci->dw.first_busno && !is_link_up(pci)) {
> +               *valuep =3D pci_get_ff(size);
> +               return 0;
> +       }
> +
> +       return pcie_dw_read_config(bus, bdf, offset, valuep, size);
> +}
> +
> +static int pcie_dw_spacemit_write_config(struct udevice *bus, pci_dev_t =
bdf,
> +                                        uint offset, ulong value,
> +                                        enum pci_size_t size)
> +{
> +       struct pcie_dw_spacemit *pci =3D dev_get_priv(bus);
> +
> +       if (PCI_BUS(bdf) !=3D pci->dw.first_busno && !is_link_up(pci))
> +               return 0;
> +
> +       return pcie_dw_write_config(bus, bdf, offset, value, size);
> +}
> +
>  static const struct dm_pci_ops pcie_dw_spacemit_ops =3D {
> -       .read_config    =3D pcie_dw_read_config,
> -       .write_config   =3D pcie_dw_write_config,
> +       .read_config    =3D pcie_dw_spacemit_read_config,
> +       .write_config   =3D pcie_dw_spacemit_write_config,
>  };
>
>  static const struct udevice_id pcie_dw_spacemit_ids[] =3D {
> --
> 2.55.0
>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
