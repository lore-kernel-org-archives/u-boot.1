Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DF8C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 11:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25F6A81188;
	Fri, 24 Jul 2026 11:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8MkOpqaEyZT; Fri, 24 Jul 2026 11:07:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD5AF81169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784891229;
	bh=y5uY0RXTi6/JdUoXQaOlb0FC4+jCcorWhwDJu/oMCZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bpHExQAdlMgrDy6qsozAwySqGVQT/575fSTMIqwSMXDS0QjhSj6Pd8r2pqFv+FzWi
	 tc1pJQxOAKj7X6HjI4CNoVNxxMG2IHTy146V+ppx6rShKYAxVOaLqkOE6Ze+uLnlL2
	 vPLrpag5J+f+X30y2tZKD3X4QJktBqaCx9II/FSTuk88xeBPUfkaPM7oE0xMRRhjjy
	 /DIyl2S0entvK7HG0l9pKC20DMkqtHcqFQlZLdStkNhj9eif5vvWsnd3lewAMN0R3d
	 KTe59mHx/GkJxlrD+4HqU5/mgVY1s/7x2d40Q0Td1fw0ra/E5644czSou4AUEYwMco
	 55M5a2cgSeAfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD5AF81169;
	Fri, 24 Jul 2026 11:07:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B60C2EB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3DAA607B8
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id obNlFmolxEHu for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 11:07:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D1E0C607B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1E0C607B7
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1E0C607B7
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:07:05 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-92e85499ffbso18629685a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784891224; cv=none;
 d=google.com; s=arc-20260327;
 b=QY6bMcDognwLFRScPAOxGQMTCwdy4Kg73DA7MbaaKCu7e6CX+NrdYALn9WVDLj5Nay
 lUbbz/eRP9k0m3Cdw6P9Yw9NUWyGUSi3bCRlHv4U8mwmYGZkbJ3RhgmovH55+18bf+07
 Wq5fLx6nyO5LKMFZHN+Ik9PV8cYPrYNqrTrWpSGgTvvsy0zBBxpmSKphXSBUfw8kL6dF
 eMA80BmVsqKfh2wh+yLSPJHykn4yhPkW+qSAITrBmmquVpeeLWXRZ0AdmEZ9TJX/PxUa
 WiDIj0+LVTVzg32p/PSq3OB1yV93OKj0CDNe1V2xt59izYKyKwXXc+5b2c6MGyTGwCtw
 Kkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y5uY0RXTi6/JdUoXQaOlb0FC4+jCcorWhwDJu/oMCZ4=;
 fh=zK9XLC41NRjeTQPH+kTbCnr0p5VLqBB/1G9KI+/M3HI=;
 b=W43AEBCcmO2BCcDmcfyPOQM4s4p4e8he3iZWjRVDgKnsyEX/A9iho4DH6sx/3epmPb
 9vEKIj6LtWUFtrwWOsyKiPuMTaopq4OKHFApxhUPihil3a0vAFXjigK9QX5gX+yQd7bS
 JD9FwEF3EU1maMy7xKNoKtdq5wXlzXkt++DhJC+oS0tKQh7/suJUyZnrhe8p45DNLAL8
 qlrqlAWtCgpgyW1SA4ebSe5dTVkhqtxNuzExgeRKgk62jIKBHSCiLtO1gSXB5R10KWxg
 FSnOZAZzPs7sYrXYGxjkYYPmhiuQX5czQAsDiWYiwuqvrGTEjZk0Y3vMCLApoSSDGjoV
 kg8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784891224; x=1785496024;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y5uY0RXTi6/JdUoXQaOlb0FC4+jCcorWhwDJu/oMCZ4=;
 b=khv1Ij1tPQ+5guv4ZtLXkEqpzkRdf3wRBQ3HaCYLrCLu+oOAfHuDeLJFQ4hYAD3jxz
 zDBvgnakOomBlrrKP91021ZCzOvomKeF2gnRi/I9lqJExXMowD83asZOmk9PIez7wdS4
 op1W0NNr44fCbHyq2Fwm5N9q8vnl4Gkxa+FfoHx0Fd5w4bDdq3T5arEoDTbUu0eZSOnm
 ygcDhZNOkZ5jJasS3UZMdJx7F9RwOw+fna4X6QS9ZhxyAcCMO8e031BmYfFacGVgdpI6
 yfnUgKz+wweNtmU3wbIlPXU4Yyk8SZW3+f8Bzkzjo657vYk0IlXRzuN1JFtqz8ZIstFl
 IgPQ==
X-Gm-Message-State: AOJu0YxKqnyudlIrYc247y3dm+W5CRBD/Qr8Wmk35xn1jKBRgg8tPidJ
 UGz7BZM/ARaHRzj3xdo6iDa3KZE2T33I3J1r4FY8i+V2G06r+rpQLhiR0HfPOkkeD9gUXoDQ0TJ
 R05pbhrzUhYU9I1o63dOoMJ4aPa+6tbk=
X-Gm-Gg: AR+sD13MHSq4eVPlf+ESbTD1TOmYsY7u/wJ81QBTxMjv9ovgYjmyOm7ZZFszbmRTwV1
 Hhceck3WfYDbDaAQqEw/l+LqbKYlsEU6JCYbwfsveCUUDB7tc6BRiFPsGcjoOdvzzmznEjO7q9c
 IPKzJSz7wFUra03+d1LuujW5Ocr6Yv5dfuUWXkFPgrtxzgPNUg5g9xnFF4z8PgFZH1ZCZq/wQbz
 Oxxc1EwV4yeLbuSNdCs2J3o4Umh/JR6iEhyhLj0VF/q7XmWiH8i5YOKKnCffwCtyrLsDOhfHLDy
 3y2pfppI1/+tbBATe/f0yCjnE5HkCfJBEHB8cc2QpNT0kPZugVXF1Xx3eQs4+BuxSFnVILAEgc6
 ZGmarz0/qqrzTFXK8b0kZqwR62yweeZ0IlxI9INnWhd2jA5Yk39o9Fuq7
X-Received: by 2002:a05:620a:2b87:b0:92e:305a:d729 with SMTP id
 af79cd13be357-931038090a1mr653164885a.7.1784891224414; Fri, 24 Jul 2026
 04:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-new-ml-mailmap-v1-1-b65a436e23a1@cherry.de>
In-Reply-To: <20260724-new-ml-mailmap-v1-1-b65a436e23a1@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 24 Jul 2026 12:06:52 +0100
X-Gm-Features: AUfX_myI8il3jH8B9REx6aJ8LBH2wiUKmSsYjLUIARv0pzBdkATzjuIA3ch4gdo
Message-ID: <CALeDE9Me5zip76v7YgS5yBRWw-4vdyjbioQ2FQxKSHvpQJMuDw@mail.gmail.com>
Subject: Re: [PATCH] .mailmap: map the old U-Boot mailing list address to the
 new one
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784891224; x=1785496024;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5uY0RXTi6/JdUoXQaOlb0FC4+jCcorWhwDJu/oMCZ4=;
 b=aWvuNGMH8ixjC6Y9d6261VD78PPk5NzWuGg2bmSz7h/hKzKvjc6UyrdNAq7Wxk6Rb+
 paUKNviyZzpcsM62txuyF51R4vT+3XYdPJQBctTIzsGs3p3B+DEa7W2IPxbZ5d+NhRoS
 TBi9t7/06b3MAzjqjYZSTFbfNqgQtDqa9fTNdEgAR3svEh2C8dYv9O6JH/xHxdo5zMXM
 +FFJK7YteGYt7Mp1GuvX0kzPQeJMSAqzDzgtqpRp0gd6zxTqx9y50cOJZ+VdoZZK+XzI
 6Npgbu+L0ddamNO1mgUr7/j3Z8G1hO3BMGfMPh96EAUD5t++LcOOWlaTYwB6B4OqNbBG
 77gw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aWvuNGMH
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 24 Jul 2026 at 12:00, Quentin Schulz via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> We have a new mailing list but the old one still forwards to the new
> one, although some people (including me) have issues with the forward
> and their mails to the old mailing list being dropped due to SPF policy.
>
> Add an entry in .mailmap so that Cc: u-boot@lists.denx.de in "old"
> cover letters and patches use the new mailing list address.
>
> Tested with b4 ty --dry-run on a series from the old mailing list.
>
> Tested with a Cc: u-boot@lists.denx.de in a commit log with b4 (b4
> send), git-format-patch and git-send-email somehow don't seem to be
> respecting this mapping. At least one tool (the one we now recommend)
> does the right thing, so it's progress :)
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

I thought we'd done this :)

> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 76ba0a7fea30..3e8822703f30 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -16,6 +16,7 @@
>  # Proper Name <proper@email.xx> Commit Name <commit@email.xx>
>
>  <duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
> +<u-boot@lists.u-boot-project.org> <u-boot@lists.denx.de>
>  AKASHI Takahiro <akashi.tkhro@gmail.com> <takahiro.akashi@linaro.org>
>  Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com> Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>  Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
>
> ---
> base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
> change-id: 20260724-new-ml-mailmap-a89fd9c55a4f
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
