Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA22CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F411941409;
	Sat,  3 Oct 2026 13:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cQDkB-yTi4Yb; Sat,  3 Oct 2026 13:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1CC2B413D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032679;
	b=nO3LYPrI43HXvK0H3sJfskHaAn9xjh0csXCQnz3xfU/pIaHqirbgBxDW8KCkvK7xGm3d
	 8UzkzLInpvHbm0FIhiXvk/OJ4bHvq7sVhkrAIW5g1jdBTFMXORMTb4JXn5EHGi6OjmXDN
	 2IYV6IKjA7oFmFWtmJHWKSkaD9NLJhsf4wepFC+OH/uy+yy4xLsGysm5oQDeUtBUa4JPe
	 2oDzEMxC7GVkIcyBnB28+53pR+1xr7ynOExLXMxtUoDoa10TCXT2A3purmloru1hGiWdz
	 8tOjFn+9MffR/I1Ltq98Pr92hy8ABrGZpf0xPTyW9VRrW059tgerbTzeXnF6gzkeYew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xlG8RQCkSh9d6STK2sgg6ajypGa4xJdCDR8HZjZvgeE=;
	b=CDI8VERkbBq1y3uVQqRdSVVMRKAS0qNk2U8TIonraHmBmVHE2vW5VILKGafETbihhnQF
	 5eZtUYmlU7QeaH6OayuirjMxEDyIMt9mV8byQSX1bW7yWHBirybukMh5F3fN5zolDwDx1
	 l0cqP9sRzckDUxasIV0P14SpO0C9gEGb8ZVHOp/Uk0kbNVf6HfDhwel58fiWPBvzFXFFz
	 H5y3K2vveEQY+qOwQTeGbLNKrbM9W0SXErg+OcVmeYKgeddCcOvlEayWacsnRdHJALKP9
	 iNYi6ZwQeOwLQEOncbIl0cyjMz+gcAci0J67VAUhU4aWWfIy0V73HFnNGvFrXu8mmwQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032679;
	bh=xlG8RQCkSh9d6STK2sgg6ajypGa4xJdCDR8HZjZvgeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOthltt+k+d7wUWepY+HPsf+XqAMsLTS0C73AlqsRM9MT3d9e+labUjsMxP6Q+efg
	 5rNtACtaJL4l8eq5ahj9jHjDRRFDdE5az/7d5am4mNb3hEy00DlwN5KwsmczHqzJs6
	 r4Obt1DkwhLGYe+YI0BiPFg3bftp+D9HYZDBhUVYcgL425Idgwnpbcnc0YyqrDbatR
	 LTSsrpn3m/dm4bqHsjqhYOmSnCVigz9YVoU50oqpHSlaQ3jbHTlrc2XP7XsCArdMrK
	 Hd5BaPxMYi8tbPjKke8vSeAjjS4/Adzg5PVRzC+IH+E9b1fsaYJCXSjc2SnRwCmDfc
	 5YhfT7iEl0xNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CC2B413D8;
	Sat,  3 Oct 2026 13:04:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 292032E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B29740063
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRpTtH_kyWHO for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 20BA240024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032676;
 b=aPLLFE9xwOqmQUtQG2XuWa0/KRc1mN8GrfgrjqhzJEgck2xP83LxPHVOBbGvVKmbbJUV
 F48Qk3OyiTLMzYnxRzRfktZ0brEuvxhuh+fJ1ejeG+Mksq7GfaSTId87Lw6PF/TXe1YwY
 qdCqWUtMdL50QZUowcn7fSr1emdrZc3LFeqK/3+d/GMo0vZB2HMAHAk7lx28HzX+9+mee
 8uqgSWMTHZrOD9b1VjgBuukgpEeZoqkBwmCB5w0q4O1OQL7o4PMBDRfZcl1O96ti+DjHb
 iJFL7g+vZSxSAs5JjS7c2B4+WVjB5+KF39EC+zTLRPYuU4LsSN+4uJcEGCRmbO9tNrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=xlG8RQCkSh9d6STK2sgg6ajypGa4xJdCDR8HZjZvgeE=;
 b=RkI2JmQKdwOUl2DM6MIQHzmCpN5nq/sXLfvGs+/ZPa+Wy52gGGfJnUbX9BcblQ+GVxqp
 KVzpSdifL4DHlX2dKD2dtMiUvVlVM7wNJEoNALe6mvjULMq7xsPfbjc7ao81WneLaQ1Kh
 TYbU/w2BiQ/MGtwWc8UX3rdL5LGp38bKL1j+bl6ChbSFFgaEpezKwlLHFj9bmdaqXxEUM
 76tHcHEyINqySo8dQb9QEv27tuiZXuhBqX6XZ6O6Si3KyTADB+ioT6kjCkyYkoHj2YIdV
 hEj+ygHXAkfP3JRQ597ofZstOQxKzy291HeKrD73SsrzO3quFALY5tPlRW7Mcdy+GLw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VFzCfXdb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VFzCfXdb
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20BA240024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:35 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6af9cc73235so909611a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032674; cv=none;
 d=google.com; s=arc-20260327;
 b=jrkPyea3cNsOso/xiHkSv0d/aZkB9zJLXd6f/COYRMZJRS2AvJd+ObZ+xx1om2LhAJ
 QF/SmTVjfZRSofS1BkUv4KX+RBPxJdaA4UnEPW+K1jhlxzEfPGCA98+/3FML8ZCUV3Hn
 CANinqvbJhlekKjWxedrdh0hCEeMUtoEVGmsoMaUNXHdb7oChaw6gklTl4DhG1U99f3A
 yogb/HX3q8e5uKRD2w9U2UYh2HIofmjsfHDmL7E9RVO2A4HpaxA6E4dm0e3zOC26hSgG
 2RnL0qqPXk0mYchLBziY2t/vEkCDc2dPjvXOdODzW9ya8hpvAtFuE+gA+AZNQC7oDhrS
 ymTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xlG8RQCkSh9d6STK2sgg6ajypGa4xJdCDR8HZjZvgeE=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=XCXV2xQ6kZAewT/TOi4jIN07oP5NB2vQUNaWkYM5t0bqG1e/VibxjLZCSug+gH/q78
 NGVapLVmGXkPDjoaIoIUoDHSZ5710vOPluipt/oNwP0LhVlBpnJ5AxP84QfGuOKUPK3I
 p8Q0QKFE2Kd8Q34oTWNM+iZFAlqnlhUMk1hxY8vFGrQ5mtVEVKx1KVODKVJ5USbyab+v
 hegLCO6Wgn8EYzosZGYBBVc3C2YU3WcseGqRC5SS8IZAjm/iznaYbDh4Jh0FgDw3Uwqg
 Z1o6LBjNlSgtfmXrlpUTb2l76v0V+aD1K82sncKVrrVqgTwuMVafzObIHBLXE8YkHF5Z
 K4Og==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032674; x=1791637474;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xlG8RQCkSh9d6STK2sgg6ajypGa4xJdCDR8HZjZvgeE=;
 b=VFzCfXdbbxYr/wdkrlEjPhx82R7KMxLez9gg0i0JDsH6UlYdJjz2PwaTOiMX4YWbnM
 XDI/dz297Axj/5AuVonwMgMqHkw3A6lnyY+4UWZZEVWL36kjEOVMs36Igpaztw4XAw1c
 XMvqNZRxduU+v+/cH7VVi++opWe5YWCbRNC5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032674; x=1791637474;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xlG8RQCkSh9d6STK2sgg6ajypGa4xJdCDR8HZjZvgeE=;
 b=ioPkxdJb+lJ0D7y+VYHTmwyW7BuvMJXaQ7djf34mGiNJB7HUaae32g9f5j0K31mI16
 0HfaZuwcjJxqWGSKlTuqijjJOxEYrFBE+De+yTt+HJEQO6Sioowiu0D1pDLXCG7CysVK
 HaBYPffFK5RgGHg/CtBAsJW9hroeWBvcVU3Qq+ztjqct8K4UOs5XUWJmbIZ5Nwnjw0cW
 VVxKsxJ7BqsWbUV4ZrFnUQZeDhu7BSMJTIOMHMSocPFkH2TxZk+uvIiWuZYRZCV6UGDH
 EY9vFbg2fqNm+xuI+CgQsWRQp0PrsVZ9MbtGkY/8MUr+SllhLZAuq7xCi99X1u/CQNOP
 xdLg==
X-Gm-Message-State: AFuF++kJfO50FW2Dve4+5rfMbDbZpKUsJUIdgmKuSUlqR3Rww1sXoQQW
 xdF5MqGFHBAZXJrs4TFGrZE4dm6wG8Beb1VVoOg89aK5S0hyzn/MPRLIU9tslBOrhBLQthyb8f2
 0bdvzldKjLyHk0giMKulku2q2cwcLY4z0oHLvxo4R
X-Gm-Gg: AYBFou0Vr9+vQocFeOK/yqBPewmOCDZMTLRFw1NmVP2fvNjzsJgfzHoNtE3c7vlopg3
 gysvA2y7nZ67YnMFJOiKzikRdsnvRC7inly7En+QStS6oTWywwb0cceqObhL4ZQ7EjnpOLjovoD
 lNsUf5rQw1GcDGGYI3inT5pJBtbmMR2KajBzTft4+YlPQGv0+PAOOzzZq/9guXx6cS3QgKMxViC
 cGX04w5WUb/mlt2SCR3OGfH/O2DDRuQ6Q0DP45ZkCwU/M+3y7egS7WbXW1qQSJ4vaGJ/kWveEu1
 XiO3ZnG006bCoEEPMR0bLOlV+A8jT0d5qlWIkVLVVwESU/xzKzT8HepvMHup9qG8FTU=
X-Received: by 2002:a17:906:d54e:b0:c2d:be57:f742 with SMTP id
 a640c23a62f3a-c2e340d7b10mr691923666b.32.1791032673746; Sat, 03 Oct 2026
 06:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-4-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-4-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:04:19 +0100
X-Gm-Features: AclHuK8p0d4293fEH4KTdGSS3rK788jp0XzUqttBWx0FgbWdFqAsc5WFGgDm8yg
Message-ID: <CAFLszTgS1BcV3vd6ETrbi_dD=iJL1JPBUgEGn_aX2HhG8_sECQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] scsi: allow a controller to declare well known
 logical units
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
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

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> scsi: allow a controller to declare well known logical units
>
> The scan walks a contiguous LUN range, so units that a bus places outside
> it stay unreachable. UFS puts its well known units at 0x80 and above, far
> past the ordinary maximum of 0x7f.
>
> Let a controller list such units separately and probe them once the
> ordinary range is done, so that block devices already created keep the
> device numbers they had.

This only holds for the last controller scanned. Device numbers are
allocated across the whole SCSI uclass (blk_create_devicef() is called
with -1) and scsi_scan() walks the controllers in turn, so a W-LU
found on the first controller shifts every unit on the controllers
after it. A board with both UFS and AHCI would see its SATA disks
renumbered once bBootLunEn is set.

Please can you either mention this limitation here, or do the W-LU
pass in scsi_scan() after all controllers have had their ordinary
range scanned? I suspect the latter is not much more code, since
scsi_scan_dev() has no other callers. What do you think?

>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/scsi/scsi.c | 16 +++++++++++++++-
>  include/scsi.h      |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)

> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> @@ -694,10 +695,23 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
> +             /*
> +              * Well known units live outside the ordinary LUN range, and
> +              * are scanned last so that they do not shift the device
> +              * numbers of the units before them.
> +              */
> +             for (j = 0; j < uc_plat->wlun_count; j++)
> +                     do_scsi_scan_one(dev, i, uc_plat->wluns[j], true,
> +                                      verbose);
> +     }

Since this is inside the target loop, the W-LUs are not scanned last
when max_id is greater than 1: those of target 0 land before the
ordinary units of target 1 and shift their numbers. It makes no
difference for UFS, where UFSHCD_MAX_ID is 1, but this is generic
code. Please can you move this into its own loop over the targets,
after the existing one, so that the comment is true?

> diff --git a/include/scsi.h b/include/scsi.h
> @@ -269,12 +269,16 @@ struct __packed scsi_write10_req {
> + * @wluns: Well known logical units to scan on top of 0..@max_lun - 1, or NULL
> + * @wlun_count: Number of entries in @wluns

Please can you mention that each value is passed as is in the lun
field of struct scsi_cmd, so it is in whatever encoding the
controller's exec() method expects (the UPIU form for UFS) rather than
a SAM W-LUN address, which would not fit in a u8.

With the sandbox W-LU suggested on the previous patch, please can
test/dm/scsi.c also check that the unit appears after the ordinary
ones, with the expected LUN?

Regards,
Simon
