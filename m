Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FABBC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DA6C810B5;
	Thu, 10 Sep 2026 14:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iG1-GjlKzm-M; Thu, 10 Sep 2026 14:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3D41780F11
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789052322;
	b=oB9gkF6stqZH1QoAiZvvnyEcuSPKJXxEb4hO9v5swS5ZlcnYynHcwjSeXokF1EukwWCQ
	 pZSkoPfuk8tLpxlzEnu6LQfw9FjTllFhaIRNN3xRpViV8dOpb6+HKFWm8kuJaKK78vIOm
	 l4o4g1wYiqVxYQTgJdVoOym5JV9kMB7+xR91g42SZTWyWqZkVauwAkGIFMcSuR9ggh+nl
	 oxXo3le5EV+Kq8o1oQXwDqvDg5njVvJjGoOnzCvkW8iIVYBZwZmOodY5HwEZwjPqKlm07
	 WZSrmycI8Dp1qrVmHnHZSwCPT/QD0AvrNDtEKTWUzzKrhwOgaOIUrSji1RjLBAtF8vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789052322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=szmtuyyj8ao98QMbZMOQB+oWGLyjrI90N4246fyU96g=;
	b=A3ZFegGayFoPFY1IUviYnHF3V/VGJDG1JsSd3GqW6xNPJn0oN2eemS04j4WbggmJInS6
	 ZuUZWnOTjxLiBFKYLcwHqTz80oqe/ePwYYlVjmj4+f1+YE4yq5uKa5ytJgdvgL80xmWVP
	 bv8XbG9kOblpFPycoJkIb8ugarkdfWD/6qOyKOBDjMkLygoECEdGbIJciSBS0Y4FJdMcS
	 kNiKKeYDCljSmWMaqpHOIMMlvyHMW+kO8JQKNx/Gxc0ZbX3BtwCeMXctNHHJVng7EqHTi
	 nFt9eiBBT9ao8oyUOh93J+IkbQf861/8/wGrsPxym3DWH84sfQKoz0G6eLOe2A8yo3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789052322;
	bh=szmtuyyj8ao98QMbZMOQB+oWGLyjrI90N4246fyU96g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bsqRvuSkFdieJ00/kCheuRrhDbYjFAOyNmml2vg4EbWkKCHA423WXnwBIWfl45n3g
	 mGLASkHhC/x0s8v3uBh+WqxkXsT9+44n8LxQoTc1l9M/Tnhd/eB6Zy03maITMloUKD
	 njkCCT5A7SPp9v4H3vf9H2U96YLu29S2YLJEO6HcWtCy2BR/oCgxe4IRwhWNs0eKvR
	 cdP35WahYsm9V+vYozyrLiBp2KTS6eKYvMi8IVyNBVN5sSndP7+tBHwproSz/meLOU
	 tn9U1Onk6RhXTnej7Zm5p2gEBZ3cPd/bXGUtSLvweYDBOU5sPEykbRGdFeL/B20yqR
	 qcm+zGpTtI6xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D41780F11;
	Thu, 10 Sep 2026 14:58:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F82E49D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 866634031C
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WJoE5PfNAs66 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 989AB40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789052318;
 b=tZtnFaKa/gt+6/ktSu+gpkgL73lejrILqQDjc6v5jPNyAEHyelDbegguffAcKi8c9Cmt
 fJDQKc2M0b0WoHdjp24d2ObXZl5tznqttYB3UztLdu/2rIhuwso65xMCTBAEiriMMPMF0
 0z6LdaEVtpJGv7DFNBpJFjvSYVPWFRIHqbPBMAmvuLUfOKynQ0zwOPiGSQcH4YdNgioig
 jIeIc5bZRQIegCzwJ0ypR+S4Xqrwcb/kemkVL9PKnvkiTSXJVSldcdMqFGa3zQO3jR2BU
 AkO5nhqYsIDmMXF5Hc071NyCkzfWWhvq3MpjqRhChNmUk4AFApfm31iocw/eiuxpCNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789052318;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=szmtuyyj8ao98QMbZMOQB+oWGLyjrI90N4246fyU96g=;
 b=fSXCDZSzzVmdd9ncBgT4K37ghibaip0LZtmolrPf+ZT/+2MMc009boOuiu+i/bbTpf6n
 DnpSaIGxFRVAqJS0TUkxJs4Rba/ESemd+P9JdyPTCrZtneV0cg7OGXBY/F+puzI2bSbfW
 19K5bh9JqPIVjxNZLPAkApBkodmGjKgrJQsjr8hi7N7T9N513TPYrhyyyCO6khocsURQ5
 5NiYKZyUkKg+igEkarhSjRrVmUx6JBRZV10Nyy6fvRsukdt9TpnyYC1emBkNdOMRwt2IV
 Dqpbj7zuQSepurweexu9+1+1w3cxz2RI7MD6pIJ4FsZruwtbsJEZz+qpwv+frT+gsHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rRY13IS+; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rRY13IS+
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 989AB40024
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:37 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so15084815e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789052315; x=1789657115;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=szmtuyyj8ao98QMbZMOQB+oWGLyjrI90N4246fyU96g=;
 b=rRY13IS+Y4QvRDAvuGsnjOfomA0ak3DWk7KwNbC9W8bFMSBUnl75s4/sPfgRbl9jSn
 37NcXLiib67zdcZrcqTEOLmB4Xh5G6dfHTMG3k52Uy4QZCcozjlsDtGYH7CkWJ2NINgY
 L2210gPFcL1Mu7w3ap3mgdy0OBwWtOFY+Qnr1sJCOs6GtedoPNkkkWTVW+dcGbFdmKlT
 newLhDkN5FtvcrcEFv+qXV824uw5ZGHha7WFNUE4RCIQEfMeISSXXPgAMYhzRrvYsa/T
 s2vqLR6Mz8ukPfvj9gABct/Ecnhg0cXZnNg5rqpbIqKn2fzx6JjW6g5BCGoIPZpTp/xg
 O7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052315; x=1789657115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=szmtuyyj8ao98QMbZMOQB+oWGLyjrI90N4246fyU96g=;
 b=OLP3nzffhdp0+fjnlmoozLyh6Udc35YL0qLvl7FhAI3KvXVoebL2pX2uUWlq9dULjT
 qMspD/G4IQ7drYLQIGaHEwan7MNHT5zj0pEM/IpFiEsAzqp4v7OBr8h6i7Vxwqkq5hji
 R5xSDLoa8i7rPc3KSAhe7iufCP2ZlDIW98lRaBnDSzAOzZ64B99xor5zT5Hhnzt1u/VH
 E0L0pj+toJuIxG9kwqSFip5aNAuf7y8X7r7qJxa/wjT962q/xGD4QW5PwN7dsRl5Qui9
 uiMu4bWCsCmfN753hTb6RcPkbae6HMm7tJqEy8XwYjgi55OcN3M7y9XB380v+vj9XaKl
 AO4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3aCx8JZKHao83ZYZMoqZQvL6wpvfegyjQTKFHI3cOZyjWIpoiLBPxYxHVc+1nrxuh92DNNbQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m4AiUZQD6hUNj6kf9EGv5xWvT374yUYIIxz1l603OR+526T5g9
 R2rvaIpuPxIT7RVE7BHXyUo0jJ8C7YIT9ciB1j5sEk2F39EMkH41yqWy
X-Gm-Gg: AYBFou2D4msPFnDt4biyEtnogdbQFqgX8IRTFj0vM/yOEXhGcJR9wQfYHgATNkjdNiw
 /56khiYb1N1LChPue953aJtJIuXB+zm4/QQB0VvRngHfuPMxdxigLM0b3piSSg3/fQCv9XJCeUt
 7mqNUPfUIYxHqaKitoUkN48d0WofSYvh4NOm9Gfzuh4oUD6m6VPeM0tpxqjAY4PWHm8dUcJhkq4
 3zYiruTSUj3ei6Hv+1zcoK/usJYDxWAt4y7E5MfUZ6Gox8cgNpL4MXKpEsMiuqZa8tWGn7em4Wo
 CFqmFoq37Dff+bPjfLUeVlko9qAlMC57idx0xReq7+S3hsx8Dv7kroe/udnWkFA2DV3lym4oCZ3
 Ulddw1GvBZdAsImsPUfZVWPdFePZQrFO50mKUN0YWKIr5eQ255VksugLwRKky/2xxFwDOXzcJV3
 mtSUDAnBBB0LP3ucCHYffpQHvuruUC3OBtEBRRPDhViMO8xjkY3wM4gT4U4TDa4mz/Aoa0+LUr+
 l7v
X-Received: by 2002:a05:600c:83cd:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-49d1f21ae99mr194146035e9.3.1789052315065; 
 Thu, 10 Sep 2026 07:58:35 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d28f44f95sm31601105e9.3.2026.09.10.07.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:58:34 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 4/4] test: dm: check the fixed regulator claims its GPIO
 at probe time
Date: Thu, 10 Sep 2026 16:58:33 +0200
Message-ID: <20260910145833.1276051-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFLszTgX_s5OB7dXP_FY933yBMRNN79wCQGpXC6wzhFw80U=QA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 2026-09-10 Simon Glass wrote:
> Pin a10 is already used by hog_input_active_low further down in this
> file.

I picked a10 after grepping for '&gpio_a 10' and the hogs address their
pins by bare number, so I missed it. Bank a has no free offset at all:
all 25 are taken between the phandle users and the hogs on 10 to 13,
and a15 to a18 are in use as well. Rather than grow the bank (three
gpio tests assert its size), v2 moves the regulator to c8 in the
pinmux-gpios bank, whose two cells also let the node carry the flags
the way a real regulator-fixed does.

> The node name regulator-fixed matches the compatible

Will rename it fixed-gpio-reg and look it up under that name.

> Patch 2 moves the same claim-in-probe pattern into gpio-regulator and
> fixed-clock, but only fixed-regulator is covered here.

fixed-clock drops out of patch 2 (see that thread). For gpio-regulator
v2 adds a node with two states on c9 and a test that mirrors this one:
unclaimed after of_to_plat(), output after probe(), voltage switching
the pin.

> gpio_get_function() returns GPIOF_UNUSED whenever the pin is not
> claimed via the DM name table, regardless of the sandbox pad state.

Good point. v2 also asserts sandbox_gpio_get_direction() is still input
after of_to_plat() and becomes output only after probe(), so the test
watches the pad and not just the name table.

Regards,
Mehmet
