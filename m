Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBC606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RuAed0uP;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B9N+geuq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9029040965;
	Wed, 11 Nov 2026 11:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOdqtzHp0p0W; Wed, 11 Nov 2026 11:45:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3A084098E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794397532;
	b=mnJxyxwYotB3nNMxKavGNLlUnUHwuDmX0dr5oqKqEhKg/k9pp9rvNJuYDQ5auCLx5sR8
	 n7VSJXI94Qdc563sqPF+eNl7qG+Ccuhws04/WKuFtnfNPWzMcNGhPdXXsXtToeQNE7IhB
	 XLtviqGIv6nwbP4iis1udx0Yls6HPjq+KdOWC81Cc1PK+8H2/GMp9R4jb35dYdW8wBekS
	 qVWgNwC6Lo2azTkAmSc58zEqkY2Lpf60aYpj6PgnBwrHRWzB+14jZN/UrT1NMUz+IR22w
	 eOmM3bMjiMUZ1awxr/MWQrGQI+MddxIIYv6R3/CzV3wH7tu66+6nGUrjh0C9iieV3Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794397532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GyNwRBF5coL17o+esaVTWf2EVFZa3imDeTGquACk3DI=;
	b=r8I8Fna6+ONxX9xod0qATqQqyMvDR4Jb7EavwSqz3+WZwWPdXGDQ5BY2L8YX+lI0dOWk
	 xpl98PANkJHOfrXTXgdmbFGcB92jlGwcNromT4v6kFXSfGCmAVfpLcX1fazd98Bf+awLw
	 hJBqVvys9/AfucFEPIHBgr4lNlVnDtgsbyHbiTH1qp0vbYJSL4mV9ASic683i2mQT1Kn0
	 rLJXqofr980hMeZvvXKCBkgVa7KQRNIM4VxV0dYPCczMXfv5NgL9VNjb0OOjeUUzwjc7n
	 0CLirczYUExhdomIvKWVzNQJZJwL8eoU6zL9sYbJ4XJqgjx6PMmlmbnyf7r8A7yc3ZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794397532;
	bh=GyNwRBF5coL17o+esaVTWf2EVFZa3imDeTGquACk3DI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RuAed0uP4sgTCex1wOKSPgE4bX8A/dTCSFR5+AanZtyXeWCXO+EhQ5/UjvEtWK6KP
	 JBCZJ+OuXFv6v+2Sr8+VefQyrvyf0T2Mg/XBXmvtg/D6xbxIth+8GZA5PQBlnIAHDV
	 5Eilz0o7YkvZhgCzoHidP3cGGT41d8G2GUeyKwIBFIW3uPpGfH9mTpqH3LFc+rWkX1
	 5Q73jqSrzP6vhRRWYiGQTJeOO+dDT8BSCUaFXmjquWT42I+sDw9x7pXH18jm+lhWtj
	 nx6RQFSGeOj3fTKPnqVUYkxxUlNwBbwIVihIzAYV5Wcj+prGcSBE38be5f0ZdAMIAI
	 nrabdaIqr9ANQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3A084098E;
	Wed, 11 Nov 2026 11:45:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08B8A1A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2AE440217
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XxPy9RMcxB4u for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:45:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DBD67400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=B9N+geuq
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBD67400D5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:45:29 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67bee1f693bso2857554d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794397528; x=1795002328;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GyNwRBF5coL17o+esaVTWf2EVFZa3imDeTGquACk3DI=;
 b=B9N+geuq6L//fPaNHJGkCLX8F0S5l+eFbfj7hD7N7rAZFpFr5OZ+9Bq7cq2RdOo/gy
 Eoj2ZcKSIxSI9l0cxlgAFWiRkffusXQBZ1cPDZ4eUoT7BWjnLNZNpJEAYGvSSyAyCBhi
 WPVaMw32cdG9bmJZ+WZm2VXs7o2Svf1muJuzElSDkSpDH7cdXKS5cnqmbKI6XHKfceln
 sfa+y3h3mQItKWolZKUMHmnT4xxjUtj7ImYq8CYgbRtwHl9YbSpGIpkHFfopqxqc54u5
 g5kHh5fjJQlMlbIYYFYrmqE37gD40O5W8JK5K5sO2VjZwrHnmjs2RK0GTAzP6t5P32hX
 OZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794397528; x=1795002328;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GyNwRBF5coL17o+esaVTWf2EVFZa3imDeTGquACk3DI=;
 b=R3yGvzf9a7Wm6vgXm0TdH74U7treqJwaOMvQqQTzjc8u2s10ZfpL8EDaljil0+VHEN
 E9ozcTqqqRGdxWT2NotczgD4e+/fMPipbusmx/u8A57wq6rI2orgv0JwzWuXOfeuKJ3f
 c7nj+S4gXtKSZt4AoMpRr4oLV3eRlqh1KHDNWBDPf8/U6I7jM/2j58Kn0uZxxhtzRWPD
 liM/dM+SJpcolwgf8S9XYYYvzePsrZURbxdXTBkwJM9F77aQuDcjoZvPF5nsM9oiVZTt
 ysEQEjig1iVCL3HjmdulyuuKK1crnjn6grI8JL+wnCn0R1BkmQi3n5yUIEHOIOZLb5R2
 AcMw==
X-Gm-Message-State: APuU4Z83JuccIadE9lDBF7IFOGmNFX3BqvmT2llj6Agt0ewpldysxNrw
 ADsE9cvaui61eKFaXVmTArllW+ptx/+xvnGwI9KrTW4lApMi8hW/8j9uxc10nGxpQ+7CPkgiaBH
 U2qd5Vga+4U0depSBG/mLgusO2HA4m4YpJg8z341JgQ==
X-Gm-Gg: AYBFou2TcRJgZpjwxUaxPX2ieAVQKAILGCQa/yEi7Wt14jaLwHQugJsXIFdWUk7/ovC
 i1903bbRseH8ykfXHwaIuFUp+yT+YHKpOSbzmXMWBjvM8GhmeP3Jq23GPXYr35P0V+/AGF164nm
 PuoH6ohv1rHJzDXrDjjioBwCpZ8v1m+cK6+7wEttTbvdfA/PrL5BEtO+zTj2j5J3sFa+JY3/5Qv
 AcW3zRYfbJImKy3G7vK2oSP6GGl6UrfOc7TQTpjjDnuaSgx26IArq0J/V3T7Y8RQFVtd6+0pP26
 Ya42qVapmlzARXO8DkTaAM+EC4PELXxcS9YY0UuYXfcIPRTxaLHU85B8FBzn3rn7sXUO/x5nzs0
 UG31Tzgd/I4KpBqjt8sLMvm4Ua4VBQpyxHAo5x0zzzrt0x05hxONqrN4xB/8xJxQoz+tehHQGgP
 zN4b3y13fghtbRhh6Lv3R4oAwXuH8haT+LCdAFKllnzHuHKPvdejJq8qrB0b9M3axzKL9QB93dQ
 FMqgyxYI2sjc35p4bs2rsdX3AlxlU5z0D5HRxWbISX9jT5HRxwFtbXju2EPoFLVwAcPyT1BjTas
 PgoUvzeh4IrvD+XuQmv8sgwGqZ54BEdGZb+yhiADtVLN7EPB0dwXO+J/hXI8aFRlj+5Un3Gkx0K
 Xkylah4zcYF6pbt4OTh6ihVtf5nyDS3GkD07j1QBVKcfaHkrtZGYcUvnWxBl6fCbJyCAMvbRUwo
 48o1jBjtd3mPMjmsjYg5vSf+QphIqFF9yghwU=
X-Received: by 2002:a05:690e:144b:b0:679:9b73:bfaa with SMTP id
 956f58d0204a3-67c67f0022cmr1887086d50.35.1794397527972; Wed, 11 Nov 2026
 03:45:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-3-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-3-701a62dfa034@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Nov 2026 13:44:51 +0200
X-Gm-Features: AclHuK-SgUK0nexMRkl2VgA5_gRt8lUHR0RtVnEhVIgnDZcIcREo2gIHe-1r8Fg
Message-ID: <CAC_iWj+OikJL7w6ye5U29fyE-h=HU0bEaXqq9w4g+w+OEty1NQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] tee: optee: keep UFS RPMB discovery state consistent
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Carlo,

On Wed, 11 Nov 2026 at 12:21, Carlo Caione <ccaione@baylibre.com> wrote:
>
> Reject frame requests until discovery selects a region, and invalidate
> that selection on every discovery failure. Keep the cursor on a region
> whose metadata read failed so a retry does not silently skip it.
>

The commit message does not explain why any of the above is needed.

Thanks
/Ilias
> Fixes: 3b39df3bc540 ("optee: implement the RPMB subsystem interface for UFS")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  drivers/tee/optee/core.c          |  2 ++
>  drivers/tee/optee/optee_private.h |  9 ++++++++-
>  drivers/tee/optee/rpmb_ufs.c      | 18 ++++++++++++++++--
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index a47c76811cd..2abdfd99e5d 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -829,6 +829,8 @@ static int optee_probe(struct udevice *dev)
>         u32 sec_caps;
>         int ret;
>
> +       optee_suppl_rpmb_init(dev);
> +
>         if (!is_optee_api(pdata->invoke_fn)) {
>                 dev_err(dev, "OP-TEE api uid mismatch\n");
>                 return -ENOENT;
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 5c72b280058..3f9fea532e4 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -34,7 +34,8 @@
>  /**
>   * struct optee_private - OP-TEE driver private data
>   * @rpmb_next_region:  next UFS RPMB region to report on PROBE_NEXT
> - * @rpmb_cur_region:   UFS RPMB region selected by the last PROBE_NEXT
> + * @rpmb_cur_region:   UFS RPMB region selected by the last PROBE_NEXT, or
> + *                     UFS_RPMB_NUM_REGIONS while no region is selected
>   */
>  struct optee_private {
>         unsigned int rpmb_next_region;
> @@ -97,6 +98,8 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
>  #endif
>
>  #ifdef CONFIG_SUPPORT_UFS_RPMB
> +void optee_suppl_rpmb_init(struct udevice *dev);
> +
>  void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>                                       struct optee_msg_arg *arg);
>
> @@ -106,6 +109,10 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>  void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
>                                  struct optee_msg_arg *arg);
>  #else
> +static inline void optee_suppl_rpmb_init(struct udevice *dev)
> +{
> +}
> +
>  static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>                                                     struct optee_msg_arg *arg)
>  {
> diff --git a/drivers/tee/optee/rpmb_ufs.c b/drivers/tee/optee/rpmb_ufs.c
> index 0c820e9595d..fbb56305609 100644
> --- a/drivers/tee/optee/rpmb_ufs.c
> +++ b/drivers/tee/optee/rpmb_ufs.c
> @@ -8,6 +8,13 @@
>  #include "optee_msg_supplicant.h"
>  #include "optee_private.h"
>
> +void optee_suppl_rpmb_init(struct udevice *dev)
> +{
> +       struct optee_private *priv = dev_get_priv(dev);
> +
> +       priv->rpmb_cur_region = UFS_RPMB_NUM_REGIONS;
> +}
> +
>  static int optee_rpmb_get_dev(struct udevice **scsi_devp)
>  {
>         struct udevice *ufs_dev, *scsi_dev;
> @@ -32,6 +39,7 @@ void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>  {
>         struct optee_private *priv = dev_get_priv(dev);
>
> +       priv->rpmb_cur_region = UFS_RPMB_NUM_REGIONS;
>         if (arg->num_params != 1 ||
>             arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
>                 arg->ret = TEE_ERROR_BAD_PARAMETERS;
> @@ -39,7 +47,6 @@ void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>         }
>
>         priv->rpmb_next_region = 0;
> -       priv->rpmb_cur_region = 0;
>
>         arg->params[0].u.value.a = OPTEE_MSG_RPC_SHM_TYPE_APPL;
>         arg->ret = TEE_SUCCESS;
> @@ -57,6 +64,7 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>         ulong cid_size;
>         int ret;
>
> +       priv->rpmb_cur_region = UFS_RPMB_NUM_REGIONS;
>         if (arg->num_params != 2 ||
>             arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
>             arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
> @@ -78,7 +86,7 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>         }
>
>         while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
> -               unsigned int region = priv->rpmb_next_region++;
> +               unsigned int region = priv->rpmb_next_region;
>
>                 ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
>                                                &rel_wr, cid_buf);
> @@ -86,6 +94,7 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>                         arg->ret = TEE_ERROR_GENERIC;
>                         return;
>                 }
> +               priv->rpmb_next_region++;
>                 if (!ret)
>                         continue;
>
> @@ -120,6 +129,11 @@ void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
>                 return;
>         }
>
> +       if (priv->rpmb_cur_region >= UFS_RPMB_NUM_REGIONS) {
> +               arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> +               return;
> +       }
> +
>         if (optee_rpmb_get_dev(&scsi_dev)) {
>                 arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
>                 return;
>
> --
> 2.56.0
>
