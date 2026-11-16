Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A84606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EmrTOVva;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GUpl7zxZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D603F80A88;
	Mon, 16 Nov 2026 13:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQEpHTTBR-au; Mon, 16 Nov 2026 13:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AD9C80ADC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794835191;
	b=KcbajX6dBqjd8EnhmuU+eEyKbiSia6v84SDnsChe8w4z5f/I/RSz5G5ajrpcaqOn2+2b
	 eBJbZCrSXwtLNtMJatlXC8JFj/1scyL0KSUp8xdlQ49hQoYQSkIa+DHZFk/c0Nseg8rHo
	 VFj7TheIqf9yLBu7iE94utpcdRtVImotnix8RVXe87vAfh3AhPGN4ji93gY6yoo86zBbC
	 Q8YtRbyv64auAIkMNKV37Mhvrmqk8E5RuZ6WZcLoENh9WQS28YeKpHUa+wnObxakNFkI6
	 UEBEA3s3cpoVgtAM+SomB+GKeXlJTcEJaKRfO8YCZxffrOfCyR1oDD1XGEHz8forZOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794835191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m2QvMRo3xhsEKowEuGUqbaw5b7nU0LjUmP+BO2wxu7s=;
	b=BzuZ8Ux4E0KoBSZKTAk44pLaYOXOODVHqzdlAbdovbWLCsz2EwvNilqvUjV/83JxrC7C
	 K5ncC3opGmTRPaIo0mwjYih6LnybCzidAOr0u1omYJwNtZWMkyTMxcsAJxaKj3u+dDfgR
	 GC5E7YnGx0IXckmA6TdyJu0nqv7lF415LC8bOwXhJikdFUtzTIWAeUgJwaWJ7BCy4ms5F
	 Hm4DPszhJRvqCoQQErySwwuSuuq6i+VR8WD00Hwkbm1V4wG35OU9kK0yiOxZUMM+aqPCM
	 5uuTGpemTqtun7lKy6fTcBERHq1+ZCxCS0iJa0b17G19lYVWKlykSX718dnT+5RBbFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794835191;
	bh=m2QvMRo3xhsEKowEuGUqbaw5b7nU0LjUmP+BO2wxu7s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EmrTOVvavgEl53cr3S2NYC/Pu9Oq0wCdRMNwhlvOgKEd9Qss0etGWXSj+Mbe3kL8/
	 zzqRUYnPB4sfnUtbHxH+eKOH9Yg1pS/TI+OWgAmu+I0DoscAHNweA6eixNq0EhR/mf
	 FdFXsOrglcr6x7t3Dv16xq2Io0UapgukCb/xWJTHOah7jYtTpMsC4XONKPMDdsS41I
	 vkA6FjD6TFs22nLEcJptd1ZhiIe73yt6a2uWHLtW+hZymQS5PWCyX0Jzl3tZwKOfN9
	 V8z7axQbabkD3jiwTj7eSRng9Ipdc1rG9MOeTOkLJqOeIgT2g3YsalQ2nqQZqpPyfu
	 HwNnw18GiHEuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AD9C80ADC;
	Mon, 16 Nov 2026 13:19:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E1A028C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73B85607A8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3K6gfoLNZ623 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:19:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 47FD460768
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GUpl7zxZ
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47FD460768
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:19:48 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso77274f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794835187; x=1795439987;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m2QvMRo3xhsEKowEuGUqbaw5b7nU0LjUmP+BO2wxu7s=;
 b=GUpl7zxZ+0jthLmsOe1rvdBFjBMMDAhDYD60jlZWfh7piSvjzpwO1tH2N1/RecGS0q
 yp5fh9qHYN9jnHH4CFr5fwAP8vfXIV1tdR4f2FUxiBTwWeNkEn+KDc48MIgJ3rBEsiCc
 C9qPUE9Dhb+hOfdmBR73xpSsx37cxx8nZWccViW4SvmwHztxo8tMGa0+A1L83wezE2Xx
 OxzF0ySHHQSubyBZrRPXqKhPxuDYSRS7wLMiVdC+mA2m0GQJfEF7DgvtGADa9VCqNXNM
 8zwsjU8sGOkFAepQhcJWCo9OjPYQitzqO0vV85Sp17bOtcCpgd0+Tjj/ilLFFegO5Jif
 jFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835187; x=1795439987;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2QvMRo3xhsEKowEuGUqbaw5b7nU0LjUmP+BO2wxu7s=;
 b=M9yq7rQZI8jPKG8/5BDEE/EWdfgr5hH7mZWiEc9zXIkWC2MtlzIBDnaGdZi2pIDfur
 xsZUFRwWWsZFagIde91Hb82V3RZSJEJFibPaYEfcMlUu5y6Di3xY/5vG/KBOsWr0f3dP
 v/hwPSEiNqtC2D8o7EbhBVM3Wwi9xmUv4wIrcl0aN8XAedCaTBzsitv39JeMoxWGwA/y
 29bcbDHoW9zgyvDTs4aZqhiMH1SUsSNUlwMR9iQiJO/Jpdk3DkKLqo/3sZovXsa7cXm8
 SVYESpyxIbfyp51bTF6RfPIzDqTw41gSYsFZCVWDmRcD7C4ZWdAOARiLBOo4z14z3nFy
 6qKw==
X-Forwarded-Encrypted: i=1;
 AL+hErER0o5AYBhOiVO3az7ap+pYdLyx4oCWjSCBnj7ajAyYa7fL40yR/sALlTvgehyHFzMiYBct6hI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9K5cOfdyoL71On4JCI5koUXFv4yNuaLa4Y3/nsORVnTE3/JDwq
 2o1QSrUBi+Ocv/4qU+CSubppkiT4iezTLk922ZqvdftTYovuVwYcXY0NyQiG3vi+RSA/JQDm+i+
 MUJ+IDpc=
X-Gm-Gg: AZFdTZe7ggFzuDWS5JhJfEGLVoKv5FyDh+PtkqQ6P0XI3IuWw9HlrXzgnUmszJs2a8k
 BC7pN8FH4CF9+YsVxV4f4pXlklD39zBP0h/keFykeP3ohF4ncn3MPS1fjSyllpoQRMnwTGlzjka
 7mo+xPi/O/vlzHy8lFq0wI4LNwRGZLjHtkhJMHeS8G7Ku/wxmPJcxmmsYcn72zoYtaPMGWUTyuu
 Ih8bdnvpJ1QzAURQGYM1UIoW0koMPoBPUxkL0bVRganmfz6XRDusWUIOts/IVEz83U03/oEBK9b
 txKRIgvL7ifbwKBuhU7UVQ4galx4HJIBQ7TKzuGpSnrU7QeIv1zfMdfFJFNoNQIor4Tyf98z/7T
 Y1ibDva6PgOdkvnFjAEBjgrdB5xCEd3Co0GZZaV4p0linY3Q5tzcqUY2FTdXQgxBrWcXhQFTSiN
 gxFQZvjpjGwaGpHGEoezB/INpvApn5/MGPzqEVSJIanmjOZsOt6ZG2CnlIfgY6pWrz9+4rsv4Ea
 INz6xB2M28nFSsif0v0N52p3m4/xHVBdXMoPD9SvxEeIOsNt/Dcb7Ga8fbx6xFzxunPcmJVBG9L
 VuZOWnQNb3RQ3iitkswYkUJZETc9Blmy6ANepkMrnExKjo31NHRQPHpJb/5a8PxMl8bAhK7r5cc
 WBVFGWLza5iGJDEjJJisd2dR9eqDsUmKRA7p0hea1n+zgGam9sALIMf16qm1+IAB2WKQp1jmB7z
 5qX8QV/HDe5+hiZCH83fPHinoisZC1w00JznIdLIC6n84b0zJcBR713PDbOW6vwqrssN4nJuzCk
 HCOIOn1VCO02i87Lm7pAeCHM8yMetZR4yMbiXMAbScRJqBE+36lY0JaGU/EbR7Wgl7qcX6Lrye2
 ysV4dBteRWezFxAsLYExs/iNPeDJm3XIXi9rwqSeLnqc/l2YY0lqItgrxKuI9LYHBc/JCGRQPNy
 0CPd/UDDWHZ783f5rF9/WtzAvVVUg/Rb/mkhJN/iLU4n912PwqcankezB+H8zUiVvUVm9CA==
X-Received: by 2002:a05:6000:4213:b0:493:8c32:94 with SMTP id
 ffacd0b85a97d-49c726db093mr21107569f8f.38.1794835186980; 
 Mon, 16 Nov 2026 05:19:46 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d22394esm22923210f8f.3.2026.11.16.05.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:19:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 15:19:44 +0200
Message-Id: <DMWNZ0QJD18L.3OSZ80YNFQ5A3@linaro.org>
Cc: "Jens Wiklander" <jenswi@kernel.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Tom Rini" <trini@konsulko.com>, "Jan
 Kiszka" <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 2/2] optee: do not announce RPMB from within a
 supplicant RPC
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Igor Opaniuk" <igor.opaniuk@oss.qualcomm.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
 <20261029-upstream-optee_rpmb_b4-v4-2-e2e4c5330d37@oss.qualcomm.com>
In-Reply-To: <20261029-upstream-optee_rpmb_b4-v4-2-e2e4c5330d37@oss.qualcomm.com>
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

On Thu Oct 29, 2026 at 5:44 PM EET, Igor Opaniuk wrote:
> mmc_init() calls optee_rpmb_available() once the card has been set up.
> When the first initialisation of the eMMC is triggered by the RPMB
> supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
> mutex, the announcement opens a nested session to device.pta, whose RPMB
> enumeration takes the same mutex. OP-TEE's second thread then tries to
> sleep through the notification interface, which U-Boot does not
> implement, and spins forever. This happens whenever a TA touches its
> RPMB secure storage before anything else in U-Boot has initialised the
> eMMC, for example a TA call issued from the shell right after reset
> ("optee_rpmb read_pvalue" with the AVB TA, "tpm2 init" with the fTPM).
>
> Linux never runs into this: the RPMB device is registered by the MMC core
> long before any TEE client, the OP-TEE driver announces it from a
> workqueue rather than from an RPC, and the kernel implements the
> notification wait. U-Boot serves every RPC synchronously on the one
> thread it has, so record in handle_rpc() that a supplicant request is
> being serviced and skip the announcement in that case: OP-TEE is using
> the RPMB already and will find the device when it probes.
>
> The counter lives in the OP-TEE driver's private data and is therefore
> maintained in handle_rpc(), which only the OP-TEE driver reaches, rather
> than in optee_suppl_cmd(): the sandbox TEE driver calls that function
> too, with a device whose private data is its own sandbox_tee_state.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Tom can you pick this up directly? I can do a PR, but I only have a single =
OP-TEE patch

Thanks
/Ilias
>  drivers/tee/optee/core.c          |  7 +++++++
>  drivers/tee/optee/optee_private.h |  6 ++++++
>  drivers/tee/optee/rpmb_emmc.c     | 11 +++++++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index a47c76811cd..f7670096b61 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, u=
int num_params,
>  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>  		       void *page_list)
>  {
> +	struct optee_private *priv =3D dev_get_priv(dev);
>  	struct tee_shm *shm;
>
>  	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> @@ -450,7 +451,13 @@ static void handle_rpc(struct udevice *dev, struct r=
pc_param *param,
>  		break;
>  	case OPTEE_SMC_RPC_FUNC_CMD:
>  		shm =3D reg_pair_to_ptr(param->a1, param->a2);
> +		/*
> +		 * Tracked here rather than in optee_suppl_cmd(), which the
> +		 * sandbox TEE driver shares with its own private data.
> +		 */
> +		priv->in_supplicant++;
>  		optee_suppl_cmd(dev, shm, page_list);
> +		priv->in_supplicant--;
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index 5c72b280058..416fa66db4f 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -35,10 +35,13 @@
>   * struct optee_private - OP-TEE driver private data
>   * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
>   * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
> + * @in_supplicant:	non-zero while a supplicant RPC from OP-TEE is being
> + *			serviced
>   */
>  struct optee_private {
>  	unsigned int rpmb_next_region;
>  	unsigned int rpmb_cur_region;
> +	int in_supplicant;
>  };
>  #else
>  /**
> @@ -48,11 +51,14 @@ struct optee_private {
>   * @rpmb_original_part:	the previosly active partition on the mmc device=
,
>   *			used to restore active the partition when the RPMB
>   *			accesses are finished
> + * @in_supplicant:	non-zero while a supplicant RPC from OP-TEE is being
> + *			serviced
>   */
>  struct optee_private {
>  	struct mmc *rpmb_mmc;
>  	int rpmb_dev_id;
>  	int rpmb_original_part;
> +	int in_supplicant;
>  };
>  #endif
>
> diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emmc.=
c
> index d4abc48f764..a40573c9281 100644
> --- a/drivers/tee/optee/rpmb_emmc.c
> +++ b/drivers/tee/optee/rpmb_emmc.c
> @@ -210,6 +210,7 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>
>  void optee_rpmb_available(void)
>  {
> +	struct optee_private *priv;
>  	struct udevice *dev;
>  	struct uclass *uc;
>  	u32 tee_sess;
> @@ -219,6 +220,16 @@ void optee_rpmb_available(void)
>  		    !device_active(dev))
>  			continue;
>
> +		/*
> +		 * mmc_init() may run from the RPMB supplicant itself, while
> +		 * OP-TEE is blocked in that RPC and holds its RPMB lock. A
> +		 * nested call would then deadlock, and OP-TEE is about to use
> +		 * the device anyway.
> +		 */
> +		priv =3D dev_get_priv(dev);
> +		if (priv->in_supplicant)
> +			continue;
> +
>  		if (optee_open_enum_session(dev, &tee_sess) !=3D 0)
>  			continue;
>

